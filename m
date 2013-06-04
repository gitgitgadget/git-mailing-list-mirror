From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Tue, 04 Jun 2013 11:30:29 -0700
Message-ID: <7vvc5t7mpm.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
	<7vehcidg1i.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DvtiT6hi-RoPt_bVdGr01S367usz=089E1Ht+Bvh-tA@mail.gmail.com>
	<7vbo7l93t6.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_Xr4bymmDezTF8BMiMKQZFpNuxXpFZd_TGJ3BkJWdGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 20:30:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujw0J-00005L-9W
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 20:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab3FDSah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 14:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab3FDSad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 14:30:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3ACA252D6;
	Tue,  4 Jun 2013 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ECYYbKbxGGzht3P2S0yShKDmznE=; b=wKX7xK
	otMsqlTsUtyHrKrYgn4nh3FCS427e8QbV8zOPsziVyKNA4DnTuHafRmDJ0om1pnp
	hU2fcHZUKjm0VRaRqv99kyq9RtN1jjgZGkdPfZ5rou9nSxu/JPQyq4bAb6QpmVhm
	EKpeQyMGiEnm9vohydL74si6sp75IPs9Jz/Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N6kxiUYtyRvOx7D/W2v4BO/nP6TGtpaQ
	Xsxd9yt0zBhmllQT6riEDz2Vlz1kfbZy2uJs7CmgLVzmxDlsK2M8+gxkmCRekOHD
	CSKBQHXGK3O7M3S71KbMQb53UkHYnYl/Dtbla1eqk+NX1k0gyRwGmlIiSlpG+PMK
	gbKjcKU3AqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8267252D5;
	Tue,  4 Jun 2013 18:30:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE29C252CE;
	Tue,  4 Jun 2013 18:30:30 +0000 (UTC)
In-Reply-To: <CAMP44s2_Xr4bymmDezTF8BMiMKQZFpNuxXpFZd_TGJ3BkJWdGw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 4 Jun 2013 12:40:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6364314-CD44-11E2-80BC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226390>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> You didn't answer, what happens when you run --skip-empty and --allow-empty?

I'll answer to a slightly different question: What should happen?

I think it should error out, because --allow-empty is about
"allowing empty commits to be preserved", and --skip-empty is about
"skipping empty commits (as it says on the package)".
