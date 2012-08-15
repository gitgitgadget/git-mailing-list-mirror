From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 14/16] transport-helper: add import|export-marks
 to fast-import command line.
Date: Wed, 15 Aug 2012 12:52:43 -0700
Message-ID: <7vsjbo3pbo.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:01:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1jm3-0006uN-KG
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297Ab2HOUAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 16:00:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155Ab2HOTwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 15:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5BA591B4;
	Wed, 15 Aug 2012 15:52:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LiD2umfW+dA+x1Qx/Rj2SaUdvhw=; b=WkMxWi
	ILx6PJpobu2yzxjvB1JGxwMIeeqawfUP/oJCVsrBM1pDZ79fFYMx1Gtnpce6Bs5t
	87upyNx1Z/eEXE7cxV5Z7P3Pf/oV0v42bj/uw+bpsSTan/Qsv4Vhv8X3lL4cCHmf
	Em451P5hjmb08HYu1pKWXST03qbrx80dA5rww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lzKVgyRrDihUeIB+NIOSS0nTHwXe5uP3
	bmL6hzNqD5oTQPxwyDPsptQObrAvN+hcWn+FJ/HgOzhiqRTZC2/rrcxQyqDLVFhy
	WHVCMdtlav/A8I4br4Zv1cpDvZ/2mwJHgc3UGllR+bSVQShPOKhP9+xwcqh6JAcN
	e3JQDJE/A2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1B8191B3;
	Wed, 15 Aug 2012 15:52:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FCAB91B0; Wed, 15 Aug 2012
 15:52:44 -0400 (EDT)
In-Reply-To: <1344971598-8213-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C81EF992-E712-11E1-BDD9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> fast-import internally uses marks that refer to an object via its sha1.
> Those marks are created during import to find previously created objects.
> At exit the accumulated marks can be exported to a file and reloaded at
> startup, so that the previous marks are available.
> Add command line options to the fast-import command line to enable this.
> The mark files are stored in info/fast-import/marks/<remote-name>.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  transport-helper.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 7fb52d4..47db055 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -387,6 +387,9 @@ static int get_importer(struct transport *transport, struct child_process *fasti
>  	fastimport->in = helper->out;
>  	argv_array_push(&argv, "fast-import");
>  	argv_array_push(&argv, debug ? "--stats" : "--quiet");
> +	argv_array_push(&argv, "--relative-marks");
> +	argv_array_pushf(&argv, "--import-marks-if-exists=marks/%s", transport->remote->name);
> +	argv_array_pushf(&argv, "--export-marks=marks/%s", transport->remote->name);

Is this something we want to do unconditionally?
