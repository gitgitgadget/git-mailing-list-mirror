From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH bc/connect-plink] t5601-clone: remove broken
 and pointless check for plink.exe
Date: Wed, 12 Aug 2015 13:58:18 +0200
Message-ID: <CABPQNSZHtAKbe6JwxRoK3LpCabfp6r2_kTmF1qokObt_yKnSDg@mail.gmail.com>
References: <55CA6066.5070500@kdbg.org> <866a41f50ef9b4807da72576a4bca717@www.dscho.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 13:59:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPUgR-0007cr-3w
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 13:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbbHLL7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 07:59:00 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38608 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbbHLL66 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2015 07:58:58 -0400
Received: by igfj19 with SMTP id j19so11704568igf.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 04:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=T84dfAED0SpmU3RznxC4QjzdUk7fBv7iyMLKENHvV6k=;
        b=mdTh3CChobIDtkD/M15IjK+H70pyPejPDtXDd9MEaGauuMm60hasJFu6dCNN9E+Vpc
         5oMWCnhoBVgFTg/sJ0Rm6yRaaIaL66/FBUOOsXM+4uAuPVQ60mBNKtudpyRLIoSv0KeF
         GU+3d/39XBv+hGc8KZAhM1asDn6n8A16PY3EHLW4XqWwNAHqYHf4xy6rRuQ7KxFLmJni
         iEM7pw8hgcDTJhGVFejwCfu8K7vDOrJLN9fB8Mns7YqxMOobBAmQO9+ftecl6qSyrXqq
         29DPg/R2yVolhTg1jYue1UOY7ZcKqbd6Z+JI+MV2HHybLap8pzJT/wmKVCxHlnWpCH/8
         LWMQ==
X-Received: by 10.50.78.133 with SMTP id b5mr22389692igx.70.1439380737847;
 Wed, 12 Aug 2015 04:58:57 -0700 (PDT)
Received: by 10.64.227.110 with HTTP; Wed, 12 Aug 2015 04:58:18 -0700 (PDT)
In-Reply-To: <866a41f50ef9b4807da72576a4bca717@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275761>

On Wed, Aug 12, 2015 at 1:07 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Johannes,
>
> On 2015-08-11 22:51, Johannes Sixt wrote:
>> Invoking plink requires special treatment, and we have support and even
>> test cases for the commands 'plink' and 'tortoiseplink'. We also support
>> .exe variants for these two and there is a test for 'plink.exe'.
>>
>> On Windows, however, where support for plink.exe would be relevant, the
>> test case fails because it is not possible to execute a file with a .exe
>> extension that is actually not a binary executable---it is a shell
>> script in our test. We have to disable the test case on Windows.
>
> Oh how would I wish you were working on Git for Windows even *just* a bit *with* me. At least I would wish for a more specific description of the development environment, because it sure as hell is not anything anybody can download and install as easily as Git for Windows' SDK.
>
> FWIW Git for Windows has this patch (that I wanted to contribute in due time, what with being busy with all those tickets) to solve the problem mentioned in your patch in a different way:
>
> https://github.com/git-for-windows/git/commit/2fff4b54a0d4e5c5e2e4638c9b0739d3c1ff1e45

Yuck. On Windows, it's the extension of a file that dictates what kind
of file it is (and if it's executable or not), not the contents. If we
get a shell script written with the ".exe"-prefix, it's considered as
an invalid executable by the system. We should consider it the same
way, otherwise we're on the path to user-experience schizophrenia.

I'm not sure I consider this commit a step in the right direction.
