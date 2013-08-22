From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after
 non-dumb push
Date: Thu, 22 Aug 2013 12:20:42 -0500
Message-ID: <CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 22 19:20:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCYYz-0006pU-3f
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 19:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab3HVRUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 13:20:45 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45134 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab3HVRUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 13:20:44 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so1945373lbd.38
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lz8YFMKIQnhDEQ4NunwRL5A71X7/ZZiYkTM2sEXlPvY=;
        b=GEO+5IOfX901TM6zcQvaXjbwiHiwXvYl1gsNibSSpkRZ2UEckNxc4m5WEbKjQN11L/
         AfuSQrcJKllap4zbddjn9NXOWlgZsLDF2euVaNxExsswHyGzyv3YvguAO3xbb73bcM4Q
         vY8ObbO0GsHEvIx9X+iy+9UGuTNCBV828xbgA1BUyC8E6oNg8IueLfzEAWTTbfV+zmxQ
         /gr6AtxU0FVOEVIX8iVaDm+kknroqJlbiiSc2u88nbNRAVrl/uSxEWy0nRh0KFNequ41
         Sx08ZO3aNehg3gCmxebZ8l16UZnnzQ3gaAHJcKdqd/Dc5yO8IGzSr/aDr45CwTGqD/+8
         Pouw==
X-Received: by 10.112.156.166 with SMTP id wf6mr12347356lbb.13.1377192042947;
 Thu, 22 Aug 2013 10:20:42 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 22 Aug 2013 10:20:42 -0700 (PDT)
In-Reply-To: <vpqa9ka7mku.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232768>

On Wed, Aug 21, 2013 at 4:36 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Aug 13, 2013 at 8:31 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>>
>>> Felipe: Is this the right fix for git-remote-mediawiki? Any better idea?
>>
>> Why not keep track of the revisions yourself? You can have file where
>> you store which was the last revision that was fetched.
>
> I don't really understand the point of the "private namespace" anymore I
> guess. Why do we have both refs/remotes/$remote and
> refs/$foreign_vcs/$remote, if they are always kept in sync?

They are not always in sync; if a push fails, the private namespace is
not updated.

> Keeping the last imported revision in a separate file would be possible,
> but then we'd have information about the remote in one file plus two
> refs, and I don't understand why we need to split the information in so
> many places. A ref seemed the right tool to store a revision.

As I said, they are not exactly the same. It is possible refs/remotes
point to a mercurial revision on the remote server, and refs/hg points
to a mercurial revision on the local internal repository, and they are
not the same.

-- 
Felipe Contreras
