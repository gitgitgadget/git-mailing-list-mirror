From: Elijah Newren <newren@gmail.com>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Wed, 17 Aug 2011 13:36:32 -0600
Message-ID: <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
	<CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Owen Stephens <git@owenstephens.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 17 21:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtlup-00042P-3Q
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 21:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab1HQTge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 15:36:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab1HQTge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 15:36:34 -0400
Received: by fxh19 with SMTP id 19so854473fxh.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8No2z8jzNhnDQCJasoIUrPx1qJz2IPTFiQHNGFYtV7E=;
        b=t3HZthjW8tQFXOkFxJCp0XrifIxDsdqL9R/qFeDDq+EbWQa6imEH9mrM5aDsy3YO2b
         rq4rTq4CInYmz0mEIeH3LR5bsJ/YBwVQnI9/F94SrUtHG+D+Yzc65Aq0hxuA4PiJ35gW
         AuVhIwsq33WcB40AJknIgqEBRtlHRphS1lllM=
Received: by 10.223.76.15 with SMTP id a15mr1188556fak.35.1313609792941; Wed,
 17 Aug 2011 12:36:32 -0700 (PDT)
Received: by 10.223.134.84 with HTTP; Wed, 17 Aug 2011 12:36:32 -0700 (PDT)
In-Reply-To: <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179530>

Hi,

On Wed, Aug 17, 2011 at 10:21 AM, Owen Stephens <git@owenstephens.co.uk> wrote:
> fast-export gives an invalid branch name for commits, if the revision specified
> is not HEAD or a branch name.
>
> $ git --version
> git version 1.7.6
>
> $ # Create
> $ git init export_test && cd export_test
> $ touch a && git add a && git commit -m 'Add a'
> $ touch b && git add b && git commit -m 'Add b'
> $ git branch branch1
>
> $ # ok
> $ git fast-export HEAD
>
> $ # also ok
> $ git fast-export branch1
>
> $ # uses HEAD~1 instead of refs/heads/master
> $ git fast-export HEAD~1
>
> blob
> mark :1
> data 0
>
> reset HEAD~1
> commit HEAD~1

Thanks for the report.  It turns out this bug has been reported and is
in the testsuite as t9350.19 -- currently marked as expected to fail.
I looked at the problem a couple years ago for a little bit but never
finished that particular patch and never got back around to it.
