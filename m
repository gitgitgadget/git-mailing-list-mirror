From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Tue, 01 Mar 2011 05:46:53 -0800
Message-ID: <7v1v2reywi.fsf@alter.siamese.dyndns.org>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
 <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org>
 <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
 <7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
 <AANLkTimRuUdGsgkt63PspvNXXjusZeOJWMhSXQ5nS81t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 14:47:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuPv3-0003vg-V2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 14:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab1CANrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 08:47:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab1CANrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 08:47:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B595B4639;
	Tue,  1 Mar 2011 08:48:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7MZwd50W5q4JlLx6AMXltCSEQPo=; b=m1Fpq/
	BaIfaBpe6FrmiwZrValyj0nigBbZGuL8WWGzhn2b9F0bYeT8AHq3sQAswTq1Xwit
	oxJ0tgxaSaNnnt3ZXDaXxpetbL9DUAwN5BI/WvJmkLdDD+d7NRf4HxEadyfRWMuP
	gKYFJUmbRpo0iKq4VPLyHPCJC3hpmgkkubUjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PorQvgK1K+B/q+R+dCBkhBIU3+g+8m0m
	Lj9+ZDXFoA5OkhOTj0r6HOYoHtZz/Waf9atJCKkLQCrQkII2F1pUcegnU7Y+ZGis
	GMdIC2eyRRNy5BrNhuCIhRL+mun27pzlrGk2Kx4voDcO9Vh4s/R/rq36ZqJuLBE0
	V/KnuTQ5DfM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B5D54633;
	Tue,  1 Mar 2011 08:48:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8418A462C; Tue,  1 Mar 2011
 08:48:15 -0500 (EST)
In-Reply-To: <AANLkTimRuUdGsgkt63PspvNXXjusZeOJWMhSXQ5nS81t@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 1 Mar 2011 18\:22\:24 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 934B93B2-440A-11E0-9340-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168220>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Feb 28, 2011 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> But how many people may be impacted this way? ...
> Or accept that evolution is painful and go with current plan, which I'm OK too.

So even though you raised a concern on possible pains during the
migration, you think that the migration plan outlined would be the
least bad one?
