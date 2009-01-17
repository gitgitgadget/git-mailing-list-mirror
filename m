From: "Ray Chuan" <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 16:40:38 +0800
Message-ID: <be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
	 <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 09:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO6kr-0005ne-UC
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 09:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbZAQIkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 03:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbZAQIkl
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 03:40:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:60156 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbZAQIkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 03:40:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1075270wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZpPA3L8MsuwDE1Xw5HORF3AnyuT/MYQc9tsAvZPSg1c=;
        b=FdJJ+smsEJhtx7oiK1+jfgyBD7UoeL20rbYfhhmIJJuThzb2v439lq+AFz26bQQ1a3
         wCjIs6DOJW5vSF2vWq4SZkZSQeTN2m8Jwb1mHjucskzWcI+ZZiHxyXEyyJYJ5MPXkAJZ
         eFcLCT8XH5OPWXgDDjcxPVQ+5B6VdTyfCHOx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mhFXemVBw/Oa57FLhSheBIMlnyK1cCynT2GtPNK5LF9Rj7VMymZ0B0S26Ph/PcCUY0
         3u+1KzczWHD/zve1cRizNWRMx5MaqXELtGIfG4AOeeKDqLcOOo79iZdsqIRX2QTaFblC
         /T3eRLdaVEBkPb0WsMyr68XjpPtlIhdeObop0=
Received: by 10.115.76.1 with SMTP id d1mr818392wal.97.1232181639016;
        Sat, 17 Jan 2009 00:40:39 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 00:40:38 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106035>

Hi,

On Sat, Jan 17, 2009 at 1:23 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 17 Jan 2009, Ray Chuan wrote:
>
>> note: the test needs to chmod the test_repo.git folder so that
>> apache/mod_dav can create .DAV folders in it for locking.
>
> Is this supposed to explain ...
>
>> @@ -51,17 +51,16 @@ test_expect_success 'clone remote repository' '
>>       git clone $HTTPD_URL/test_repo.git test_repo_clone
>>  '
>>
>> -test_expect_failure 'push to remote repository' '
>> +test_expect_success 'push to remote repository' '
>>       cd "$ROOT_PATH"/test_repo_clone &&
>>       : >path2 &&
>>       git add path2 &&
>>       test_tick &&
>>       git commit -m path2 &&
>> -     git push &&
>> -     [ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
>> +     git push origin master
>>  '
>
> ... this removal?  I do not think this is a good change, as it removes
> a test that is actually pretty important.

i'm sorry for the poor commit message, what i wanted to do was to
change the tests to expect success rather than failure. no tests were
removed; only their expected outcomes were modified. currently, the
pushes fail, so the test 'fails as expected'; now the pushes succeed,
so they shouldn't be expecting failed pushes (or anything else).

> BTW I do not understand at all what you mean by "we need to chmod".  Does
> the Apache instance not run with the current user's permissions?

i wrote 'we need to chmod', cos i'm not sure what the permissions are
required. sorry, i didn't notice that apache was running with the
current user's permissions. but i added the note just in case, for
users who don't run apache with the current user, so they modify the
test appropriately (ie adding a chmod).

> Ciao,
> Dscho
>



-- 
Cheers,
Ray Chuan
