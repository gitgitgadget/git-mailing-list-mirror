From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Tue, 1 Sep 2009 09:31:05 +1000
Message-ID: <d2e97e800908311631x6fdd7781v2e893d1ca62378b6@mail.gmail.com>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com> 
	<fabb9a1e0908310529q4c601a73t671cc2813dfdb1a3@mail.gmail.com> 
	<81b0412b0908311427t5b4a24ffg1d7d272669476117@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 01:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiGLn-0001Pu-8P
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 01:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbZHaXbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 19:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZHaXbX
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 19:31:23 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:62084 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbZHaXbX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 19:31:23 -0400
Received: by an-out-0708.google.com with SMTP id d40so5418124and.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q/V8451sf0fDukL8zaN669f8GXzwCeHz57gqETB1yuE=;
        b=XE2rbWEW8yXCFn18dmwuEMeJqTta+lAV8/s9szpFUGgf7ahOrEG/loB23tlr99vkP/
         pXM0WJyKwyNUQD9QuLZVIRIE6lmiSpZ1oN3m09mxqku9iPyeeQvlWC9/QVhpVIVFpiEB
         kM5FbXyPUvwXHM5TfyTtiTCzpx+ml1yQn/TVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=O4r4d05qwg1YLfpNrLf7Bceho8U50/2CFpxEx72ZPY3j6Moi57Gyk41mguF1fzQL49
         EOpiNb7oGbCvGyHloqHnM471h0htN2tbUTKv0/36E7m2d0oJeXQzmBGA8lHH2MAlmBtz
         fa9laOVxtAKdqvF2S/PcINitAQtLwUUFyMq+Q=
Received: by 10.101.90.12 with SMTP id s12mr6468221anl.77.1251761485085; Mon, 
	31 Aug 2009 16:31:25 -0700 (PDT)
In-Reply-To: <81b0412b0908311427t5b4a24ffg1d7d272669476117@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127505>

2009/9/1 Alex Riesen <raa.lkml@gmail.com>:
> On Mon, Aug 31, 2009 at 14:29, Sverre Rabbelier<srabbelier@gmail.com>=
 wrote:
>> On Mon, Aug 31, 2009 at 04:21, Michael Wookey<michaelwookey@gmail.co=
m> wrote:
>>> Provide a dummy variable to keep the compiler happy.
>>
>> Should we not instead check the value?
>
> Why? It is endp (end of the parsed number) we're interested in.

Good point, perhaps the commit message should mention why we don't
bother checking the return value. Something like this maybe?

-- >8 --
gcc 4.3.3 (Ubuntu 9.04) warns that the return value of strtoul() was no=
t
checked by issuing the following notice:

 warning: ignoring return value of =E2=80=98strtoul=E2=80=99, declared =
with attribute
warn_unused_result

The return value of strtoul() isn't used because we are only interested
in what is placed into endp.  As such, provide a dummy variable to keep
the compiler happy.

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
-- >8 --
