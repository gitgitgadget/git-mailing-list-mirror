From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Fri, 21 Aug 2015 10:08:09 +0200
Message-ID: <C80E3141-C247-439B-97B5-562881C127F3@gmail.com>
References: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com> <1440014686-63290-2-git-send-email-larsxschneider@gmail.com> <55D55EC9.6050002@web.de> <917E3751-4BC8-4034-9101-30C77426D81C@gmail.com> <xmqq37ze7y4o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 10:08:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZShN8-0000tR-89
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 10:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbbHUIIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 04:08:16 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35228 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbHUIIN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 04:08:13 -0400
Received: by wicne3 with SMTP id ne3so9269375wic.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IEb+GbEPQJg/pQe1phRvxDxdtWeLLAMNaBPTURHOZnY=;
        b=c/CcNdl5xM+SzpIeVVLj2z1ZZ8NYF9p7bW+zFnZ6svUqZb6vXfcPUJTirSU/D6ADim
         P8OP8DmLw2mePhW2O7PXx9IAIbXn5z0AruKgZl1g/vmxJgc4qca5zU6TPZwACb4rH6qW
         oEGmbP/rzEfv2TpQbjZonYNzLvfc70MBblcJgAD6hvju1Qats21NqKG2nwTP8WpQGRc4
         G5KHwL5Rklnic7jPIwYhzRJEreZ++GhaGrCCqnXcDjEuMPCFB1jN9cioVya2wwYWYNU4
         Pelh8o65+/ysk4lP24wm6LbvqBKpXjYv6dSf5FlrI52c1CP4BwF/8chOjLDcTq22gPGd
         NP8Q==
X-Received: by 10.180.103.34 with SMTP id ft2mr4098848wib.62.1440144491722;
        Fri, 21 Aug 2015 01:08:11 -0700 (PDT)
Received: from [10.146.248.52] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id c11sm1852602wib.1.2015.08.21.01.08.10
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 01:08:11 -0700 (PDT)
In-Reply-To: <xmqq37ze7y4o.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276282>

@Luke, Torsten, Eric, Junio:
Thanks for the great feedback. I incorporated everything into "[PATCH v=
3] git-p4: fix faulty paths for case insensitive systems=94.
Is this the correct way? I have never worked with the email-patch-files=
 before :-)

- Lars

On 20 Aug 2015, at 17:55, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>>> +		find . | grep TWO/file1.txt &&
>>>> +		find . | grep TWO/File2.txt &&
>>>> +		find . | grep TWO/file3.txt &&
>>> Not sure about the find | grep here either.
>> See answers above.
>=20
> These are not very good tests; they will match "OTWO/file1.txto",
> too.  Besides, it is wasteful to run find three times.
>=20
>        find ?* -print | sort >actual &&
>        cat >expect <<-\EOF &&
>        TWO/file1.txt
>        ...
>        EOF
> 	test_cmp expect actual
>=20
> or something like that instead?
