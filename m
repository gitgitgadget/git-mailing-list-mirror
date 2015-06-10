From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 7/7] send-email: suppress leading and trailing
 whitespaces before alias expansion
Date: Wed, 10 Jun 2015 18:10:07 +0200 (CEST)
Message-ID: <595924690.351865.1433952607248.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqa8w89d5x.fsf@anie.imag.fr> <1281238070.338321.1433928615479.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqqa8w7oarl.fsf@gitster.dls.corp.google.com> <vpqoaknr39r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:10:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2iZm-0007Co-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965581AbbFJQJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:09:53 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:44269 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966693AbbFJQJW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 12:09:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6F7352864;
	Wed, 10 Jun 2015 18:09:20 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h8wKLDqPN9kW; Wed, 10 Jun 2015 18:09:20 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 5B7192852;
	Wed, 10 Jun 2015 18:09:20 +0200 (CEST)
In-Reply-To: <vpqoaknr39r.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: suppress leading and trailing whitespaces before alias expansion
Thread-Index: bMXS6GNQMjM20sOZMQ8LR2hs1PiWSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271316>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
> >
> >> I agree, I'd like to put it right after split_at_commas in a separate
> >> function "trim_list". Is it a good idea even if the function is one
> >> line long ?
> >
> > Hmph, if I have "A, B, C" and call a function that gives an array of
> > addresses, treating the input as comma-separated addresses, I would
> > expect ("A", "B", "C") to be returned from that function, instead of
> > having to later trim the whitespace around what is returned.
> 
> It is actually doing this. But if you have " A,B,C  ", then you'll get
> " A", "B", "C  ". But once you're trimming around commas, trimming
> leading and trailing spaces fits well with split itself.

Yes and if we have a single address with leading or/and trailing
whitespaces, such as " A ", I think that we don't expect
split_in_commas to suppress these whitespaces as there's no commas in
this address. As Junio said, I think I should rename the function.

Thanks!
