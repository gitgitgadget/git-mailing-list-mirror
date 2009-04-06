From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gnus content transfer encoding
Date: Sun, 05 Apr 2009 17:30:13 -0700
Message-ID: <7vskkmoc8a.fsf@gitster.siamese.dyndns.org>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
 <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
 <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
 <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
 <7vocvaq36x.fsf@gitster.siamese.dyndns.org> <87r60626c9.fsf_-_@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Apr 06 02:31:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqckm-0006Zm-RK
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 02:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbZDFAa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 20:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbZDFAa2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 20:30:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbZDFAa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 20:30:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EA2D2A83F1;
	Sun,  5 Apr 2009 20:30:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 512E2A83ED; Sun,
  5 Apr 2009 20:30:15 -0400 (EDT)
In-Reply-To: <87r60626c9.fsf_-_@iki.fi> (Teemu Likonen's message of "Sun, 05
 Apr 2009 23:28:22 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1EE62ADC-2242-11DE-BB57-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115746>

Teemu Likonen <tlikonen@iki.fi> writes:

> On 2009-04-05 13:02 (-0700), Junio C Hamano wrote:
>
>> Reece Dunn <msclrhd@googlemail.com> writes:
>>> I think Junio is trying to learn base64 :)!
>>
>> I think that is what my Gnus/message-mode did. I do not know which
>> letter triggered it to decide it is UTF-8 to begin with, though. As
>> far as I am aware, I didn't type anything non-ascii in my message.
>
> You can customize the encoding decision mechanism, for example:
>
>     (setq mm-body-charset-encoding-alist
>           '((iso-8859-1 . 8bit)
>             (utf-8 . 8bit)))
>
> For more info, see:
>
>     C-h v mm-body-charset-encoding-alist RET

Interesting.

I have had these for a long time:

	(setq mm-coding-system-priorities '(us-ascii iso-2022-jp utf-8 iso-8859-1))
        (setq mm-content-transfer-encoding-defaults
              '(("text/.*" 8bit)
                ("message/rfc822" 8bit)
                ("application/emacs-lisp" qp-or-base64)
                ("application/x-emacs-lisp" qp-or-base64)
                ("application/x-patch" qp-or-base64)
                (".*" base64)))

I did not have any customization on my own to body-charset-encoding-alist 
and C-h v gave me:

    mm-body-charset-encoding-alist's value is 
    ((iso-2022-jp . 7bit)
     (iso-2022-jp-2 . 7bit)
     (utf-16 . base64)
     (utf-16be . base64)
     (utf-16le . base64))

I'll have the following in my .emacs in addition to the coding-system-prio
and c-t-e-defaults I already have:

        (setq mm-body-charset-encoding-alist
              '((iso-2022-jp . 7bit)
                (iso-2022-jp-2 . 7bit)
                (iso-8859-1 . 8bit)
                (utf-8 . 8bit)))

and will see what happens, but I wonder how this new one interacts with
the c-t-e-defaults.

Thanks.
