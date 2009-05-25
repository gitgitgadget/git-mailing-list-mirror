From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Mon, 25 May 2009 17:39:44 +1000
Message-ID: <fcaeb9bf0905250039gcc0d8c1h788f726a13281452@mail.gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 
	<1242899229-27603-3-git-send-email-pclouds@gmail.com> <4A164C85.3000703@viscovery.net> 
	<fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com> 
	<20090523092603.GA7420@dektop> <20090523145042.GA13139@dektop> 
	<4A1A37AD.4080309@viscovery.net> <fcaeb9bf0905242334q37ef9a05xa05315639af4daf3@mail.gmail.com> 
	<4A1A3EF6.1050405@viscovery.net> <fcaeb9bf0905250000n299f599fp3738e5385add075a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 25 09:46:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8UtU-0001jw-4t
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389AbZEYHkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 03:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759508AbZEYHkG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:40:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:11973 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544AbZEYHkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:40:04 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1778367ywb.1
        for <git@vger.kernel.org>; Mon, 25 May 2009 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=z5JLUf4aA0kha0GBouhJWwCtMvIFMztPtNzqtBDzk4U=;
        b=p/m1D4/BGPJ58f3gW9DlnxO54epOW4Uq/B4Z9MTCbwL6vS0sVrlkaztVhhcphRi8Gi
         0yM1fxAoDTAI8gKrl31gjXtPKd7Pog8CKsREVnrdPXAyhTcEER84uGFawicFuUXoveqf
         0QV3OPpDwAWszYdk+C6bSUhFXzSfOxTrag4e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=N9JI7TA51j4OxZH+lKvUz/ZadVcq0jkvisvcZSi6/gHkIr8I5zROkOPV5H4CvFLThF
         lfHeSKNdwzlVKgnW7dMWBL83LP0TMj2WTN7hznTyTvo/kHMyqoFDPSfGZCBejURoGEYL
         2xLMyRyT6BOWwtcoummnUJYNfLA6auZUwImAM=
Received: by 10.100.12.17 with SMTP id 17mr11856530anl.2.1243237205564; Mon, 
	25 May 2009 00:40:05 -0700 (PDT)
In-Reply-To: <fcaeb9bf0905250000n299f599fp3738e5385add075a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119895>

On Mon, May 25, 2009 at 5:00 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Mon, May 25, 2009 at 4:47 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Nguyen Thai Ngoc Duy schrieb:
>>> On Mon, May 25, 2009 at 4:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>> Nguyen Thai Ngoc Duy schrieb:
>>>>> Someone with better Windows knowledge than me should explain how this works. Windows'
>>>>> snprintf() just cuts out the last character in this statement:
>>>>>
>>>>> snprintf(buf, 8, "--%s", "onto"); // result: '--ont', expected: '--onto'
>>>> This doesn't happen for me: neither with Windows's original snprintf nor
>>>> with the version from compat/. Are you using the latest msysgit
>>>> environment to compile, i.e. gcc 4.4? There was a change regarding
>>>> SNPRINTF_SIZE_CORR; perhaps that's the culprit?
>>>
>>> It could be. I used git.git's next branch, not msys4git or mingw.git
>>> repositories.
>>
>> OK. Assuming you are using the latest msysgit compiler, which is gcc 4.4,
>> then you need the SNPRINTF_SIZE_CORR related patch from 4msysgit.git.
>
> It's cross compiler 4.3. Will try the patch.

It is because of SNPRINTF_SIZE_CORR. Thank you.
-- 
Duy
