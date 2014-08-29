From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 12:04:32 -0700
Message-ID: <xmqqppfj5d8f.fsf@gitster.dls.corp.google.com>
References: <1409331522-8457-1-git-send-email-bbolli@ewanet.ch>
	<xmqqwq9r5dhb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <bbolli@ewanet.ch>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:04:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRTb-0005GZ-6e
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 21:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbaH2TEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 15:04:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62560 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbaH2TEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 15:04:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0264434BDD;
	Fri, 29 Aug 2014 15:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQ4FuhX7fVh3ItsND84SNhUWwiM=; b=gTdtYw
	cgIlrsRjNLKGJYc6srn0ZL1TmbGwPML/UIB9vly5AHbICu0EWU9a89r7OLVg0BV5
	Pw6wzepZWoGUpgM5zpKuGUMnzMhT0VAc4PT0YIofJneJ398pkLWVA8i63l/JKDgd
	pn+k0JNRkx9Dl38Mj9IGigRC9LyOSScs14Y3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZL942zEDZ1Jp3sAsdudM43V0dZqjT7u
	F9kipOQinUcrLHwuuKeHoIaonAqxwtki8EAOf8d5ZchgNel0zD1iKhsJjQ2zycmd
	3s5IuKS7G/8PhydbSe0vpQI8TKOK4uqwRnDHjSEEnA/ta1eOLoDzQj+Gtn+DoJgj
	GA+rI8JLQ50=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDDD534BDC;
	Fri, 29 Aug 2014 15:04:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B8D4D34BD8;
	Fri, 29 Aug 2014 15:04:33 -0400 (EDT)
In-Reply-To: <xmqqwq9r5dhb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 Aug 2014 11:59:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 501ABD9A-2FAF-11E4-8536-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256181>

I've queued with this fix squashed in.

diff --git a/builtin/blame.c b/builtin/blame.c
index 17d30d0..f9e6481 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2580,6 +2580,9 @@ parse_done:
 	case DATE_RFC2822:
 		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
 		break;
+	case DATE_ISO8601_STRICT:
+		blame_date_width = sizeof("2006-10-19T16:00:04-0700");
+		break;
 	case DATE_ISO8601:
 		blame_date_width = sizeof("2006-10-19 16:00:04 -0700");
 		break;
