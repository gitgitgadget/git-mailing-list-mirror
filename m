From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 15:53:56 +0200
Message-ID: <AANLkTinZ4UV9in60Y4myfUWv08Vx3OMvh-_YQl2BXSjC@mail.gmail.com>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
	<20100705025900.GQ22659@josefsipek.net>
	<67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
	<20100705185238.GS22659@josefsipek.net>
	<20100705192201.GI25518@thunk.org>
	<20100706080322.GA2856@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tytso@mit.edu, jeffpc@josefsipek.net,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 15:54:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW8bB-0000Kh-PE
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 15:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab0GFNyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 09:54:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61893 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab0GFNyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 09:54:00 -0400
Received: by bwz1 with SMTP id 1so3528714bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=IIx0hO7a23TrK6dqWxxmsHRphaVLQNXa85pNMyHLHHY=;
        b=dH21Yaqo5RISGHGtNYRJihvq8NxCSb1eUt1Iwg15QeKvA2b4qAIHA+XzLOclND7ZrC
         gCHCxnl76/oUIcPPWs3T/DBCzVz+Wn0v/+000kPjmr7zQsBTw9jdfyU4t+xqVpdw7kjG
         LYfhJsi/xB/uQQQ52GSXIs8oBz0KVWpVAjbHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=U6PKsfmoF02rA0jwJKf+yHZX1MmXZNRP5frSPjUfeA7YB7YsIGVnYZcgje++tKkiDs
         JcVCmstusnFvKzuj1ZNmRKY/3ttvkVJsXJw31gkESByWK0bZnDEg2nzeZVS0HZHIgvPZ
         eFHNMJvi338D8re4SpDJWmDvSF4UocWI0W8Wk=
Received: by 10.204.8.198 with SMTP id i6mr3748155bki.66.1278424436747; Tue, 
	06 Jul 2010 06:53:56 -0700 (PDT)
Received: by 10.204.71.1 with HTTP; Tue, 6 Jul 2010 06:53:56 -0700 (PDT)
In-Reply-To: <20100706080322.GA2856@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150352>

On Tue, Jul 6, 2010 at 10:03 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> tytso@mit.edu wrote:
>> On Mon, Jul 05, 2010 at 02:52:38PM -0400, jeffpc@josefsipek.net wrot=
e:
>
>>> if I commit, and immediately after push 10 patches, wouldn't the HE=
AD end up
>>> with a commit that's ~10 minutes in the future?
>
> I don=92t think git has ever required commit dates to be _strictly_
> monotonic.
>
> At one point rev-list did require monotonic --- i.e., the committer
> date of each commit had to be equal to or later than that of each of
> its parents) with no clock skew but that was considered a bug and
> fixed by v1.5.5-rc1~16 (Make revision limiting more robust against
> occasional bad commit dates, 2008-03-17)
>

This might be a stupid question, but I'm not entirely clear on why
it's not a strict requirement; surely it would be easy to ensure that
the commit-time is at least as big as the parents when generating the
commit...?

Is it to avoid the case where a user commits with the clock set to
some point (potentially far) in the future, so all subsequent commits
would have the same, artificially high commit time? Or is there some
other reason I can't think of?

--=20
Erik "kusma" Faye-Lund
