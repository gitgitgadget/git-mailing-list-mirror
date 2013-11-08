From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Fri, 08 Nov 2013 10:56:33 -0800
Message-ID: <xmqqhabmoh7i.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
	<vpq1u2tb3px.fsf@anie.imag.fr> <20131106234544.GF10302@google.com>
	<vpqtxfo8ow4.fsf@anie.imag.fr>
	<xmqqli0yojp8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 08 19:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VerEZ-0005HG-6T
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 19:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab3KHS4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 13:56:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757439Ab3KHS4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 13:56:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AF474DD85;
	Fri,  8 Nov 2013 13:56:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EHXVIHIFuB/APVZ+Nq6oif8ziNA=; b=VdUwMI
	psvxENQkz6PH91NPx4lvAWiY028eta6UFdykPqtksXeE8mhx7D5n+QZ7069+on/o
	e/6MvtXudkLA0l4BsXNBK4wWnvat5Gjvz2Ps4hONK8Ne6hYuVSKGWYNuDLiKuVSr
	PC5LIRyZpxy0Nn/3au0itg/3MWCF3zjxyak/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O4SJ9tKipdw/LJcUCd8GNyxJe+Ozx0U3
	TNNpvESTZOE/82lNH2XN09jgdSEY608i3Dy8dUnmMfRS9hslvV6CfGZYkXIgIIew
	GyFJSdQoIUziHdYEuU3chVWFUkfNXPOhhBjRy3r2yQeJ9uBitZI/cXxAztoHNHvB
	juE9yvuzGgI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D4114DD83;
	Fri,  8 Nov 2013 13:56:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 653BF4DD82;
	Fri,  8 Nov 2013 13:56:36 -0500 (EST)
In-Reply-To: <xmqqli0yojp8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 Nov 2013 10:02:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E23B330-48A7-11E3-9D80-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237462>

Junio C Hamano <gitster@pobox.com> writes:

> OK, I'll tentatively update the draft to read like this, redo the
> endgame patch on top and requeue.

... and the corresponding part of the endgame patch now reads like
this.  I suspect that we may want a bigger change to unstress
'simple' at that phase of the transition, though, by perhaps
rewording the 'matching' part to make it more explicit that the
setting is primarily for those who want to keep the traditional
behaviour.

diff --git a/builtin/push.c b/builtin/push.c
index 27c5754..a0534d0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
 ...
@@ -164,9 +163,9 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 }
 
 static char warn_unspecified_push_default_msg[] =
-N_("push.default is unset; its implicit value is changing in\n"
+N_("push.default is unset; its implicit value has changed in\n"
    "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
-   "and maintain the current behavior after the default changes, use:\n"
+   "and maintain the traditional behavior, use:\n"
    "\n"
    "  git config --global push.default matching\n"
    "\n"
@@ -177,7 +176,7 @@ N_("push.default is unset; its implicit value is changing in\n"
    "When push.default is set to 'matching', git will push local branches\n"
    "to the remote branches that already exist with the same name.\n"
    "\n"
-   "In Git 2.0, Git will default to the more conservative 'simple'\n"
+   "Since Git 2.0, Git defaults to the more conservative 'simple'\n"
    "behavior that only pushes the current branch to the corresponding\n"
    "remote branch used by 'git pull' to update the current branch from.\n"
    "\n"
@@ -207,14 +206,14 @@ static void setup_default_push_refspecs(struct remote *remote)
 ... 
