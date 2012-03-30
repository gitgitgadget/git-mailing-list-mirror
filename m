From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Thu, 29 Mar 2012 21:53:19 -0700
Message-ID: <4F753C3F.7010805@gmail.com>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com> <1333062296-27823-1-git-send-email-haircut@gmail.com> <7vboneq1vs.fsf@alter.siamese.dyndns.org> <4F75236C.4050703@gmail.com> <7vr4waoics.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 06:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDTqG-0004Ez-G9
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 06:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab2C3ExY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 00:53:24 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56412 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2C3ExX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 00:53:23 -0400
Received: by qcqw6 with SMTP id w6so146426qcq.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 21:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=3wV9I3QjSXLCUTN3PMS8KQFVLQ2g1ToPDp75TJiVDok=;
        b=h5LAu32LrwEnH2lqU+twwcL3S+++I2JCLiIWPtY/PidNuEXnnLQpqPi/pZCplppGdZ
         q6kc71pG0lyQeIn6scbQUdeD3MEmiON8eYBpPtHTG6ZiI4W04bUfu4wAkRbeAZWWwNiU
         mukxb+WVWT1iB3FiERFzwRGZILE0Z7co1IIv+/sap+W1ZWVc2GglP97d6wnseirp99Yz
         LjDBOvONP9uZb7nmg0C2XqYsM2bJ3xYFeFlu2shzKOMIZwdvEKnjK5WMw+05qt3mKxQ3
         1jl+Zhv+QYtizMcxF61k1YgYJ8tjCXsDjwyJSxlWTK75hZreBGatO/CIK1qGRmGtEnUf
         BNfg==
Received: by 10.224.184.10 with SMTP id ci10mr3833891qab.4.1333083202280;
        Thu, 29 Mar 2012 21:53:22 -0700 (PDT)
Received: from [192.168.13.92] (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id w9sm16427073qao.0.2012.03.29.21.53.20
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 21:53:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <7vr4waoics.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194325>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> You still say "the message is considered empty and" but I think it
>  probably reads better without it.

Do you like the patch without those words?

> Strictly speaking, it is not a "mandatory fillable form", but 
> whatever text you put in the template is advisory to the users.

Ok, right on. I understand the template feature now since you've
patiently explained it to me (thank you!). I still want to plainly
convey that even if my template is the following:

	~~~~
	zip module: continue to expand transformer
	
	This WIP will eventually provide expanded
	transformer functionality.
	~~~~

I *cannot* just save and quit my editor (unless I supply
- --allow-empty-message). That's the behavior I find confusing: git
telling me a non-empty commit message is an empty commit message. If I
save that text above (zip module... etc) in FILE and do `git commit -t
FILE`, save and quit my editor, git says "Aborting commit due to empty
commit message." Lies! A more precise message would be "Aborting
commit due to unmodified commit message template."

Based on the current documentation I misunderstood that -t could be
used to review a boilerplate commit message and save it verbatim.

...AHA! I just figured out a way to do exactly that:

	git commit --edit --file=FILE

aka

	git commit -eF FILE

Yay! No idea how I missed that before.

Anyway, it still seems like the documentation for "git commit -t"
could use improvement. I actually wouldn't mind seeing a short example
template like the one you provided, maybe in the EXAMPLES or
DISCUSSION section.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPdTw/AAoJEJtdmT+DbynAte4IALRx50yW5bEfzXskvSDewPuL
SgaU4CqUHRm8sWXHeFbd4I2rG4dEJuqYqzKKbfay3EMwEbIkThiwoC2pJ9xJoFpe
8O95GVp3ikYvsY3mn87ebiwA9FBhnTy1Fz+MREfuzETpJbdtJSHhbRXMxfJ9ZabU
FOPE/qeZDvQJA9b9QFY3QS/BcxsGHXhW9xCULZlAprDggMcchhHDEbqJCh/1wObw
cQvoONiqZSkXA17K3gxfs7NgafUVFIg3+N9vcq90eZXbT/s1MM+1zxj5ezTh9jbV
sOkzepfE5+NBK3PnewMDxDxhF0LD5lzHCwnfkTl1Om3okSE0nxVyRZKabuzc99s=
=NUN8
-----END PGP SIGNATURE-----
