From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and
 reply to
Date: Thu, 26 May 2016 02:08:32 +0200
Message-ID: <e678afcb-b378-9829-fae4-1f1ed38ee593@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
 <vpq60u4bl4e.fsf@anie.imag.fr>
 <b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
 <vpqh9dmfy5k.fsf@anie.imag.fr> <xmqqwpmi16zt.fsf@gitster.mtv.corp.google.com>
 <vpqeg8q5b6f.fsf@anie.imag.fr> <xmqqr3cqypg6.fsf@gitster.mtv.corp.google.com>
 <vpq8tyyt2fv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 02:08:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5iqv-0003gr-IW
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 02:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbcEZAIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 20:08:37 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:47045 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbcEZAIh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 20:08:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0A383253D;
	Thu, 26 May 2016 02:08:33 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YF1sFKne6b1G; Thu, 26 May 2016 02:08:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E812924A7;
	Thu, 26 May 2016 02:08:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id DDC072077;
	Thu, 26 May 2016 02:08:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXYBJAOem0i6; Thu, 26 May 2016 02:08:32 +0200 (CEST)
Received: from linux.home (LFbn-1-8166-195.w90-112.abo.wanadoo.fr [90.112.75.195])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 77BC02055;
	Thu, 26 May 2016 02:08:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpq8tyyt2fv.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295623>

On 05/25/2016 08:31 PM, Matthieu Moy wrote:
> So, a possible UI would be:
>
>   git send-email --in-reply-to=<id> => just set In-Reply-To: field.
>
>   git send-email --in-reply-to=<file> => set In-Reply-To, To and Cc.
>
>   git send-email --in-reply-to=<file> --cite => in addition, add the
>     body of the message quoted with '> '.
>
>   git send-email --in-reply-to=<id> --fetch => fetch and do like <file>
>     using the default configuration for fetch.

We designed a similar UI, except for the --fetch option:

We wanted to try to fetch the email from a distant server (e.g. gmane)
if that server address was set in the config file, and populate the
To:/Cc: fields.

If the file cannot be downloaded, or server address not set, just fill 
the Reply-to header.

Either way, display what was done with the message-id given (unless
--quiet is set, of course).

> This leaves room for:
>
>   git send-email --in-reply-to=<id> --fetch=gmane => fetch from gmane
>     (details on how to fetch would be in the config file)
>
> This UI wouldn't allow using a file to get only the message-id. But I'm
> not sure this is an interesting use-case.

IMHO when you reply to a thread with a patch, it seems
counter-productive to reply without notifying (putting in To:/Cc:) the
original author and people involved in the thread.
