From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Fri, 01 Nov 2013 09:35:52 -0700
Message-ID: <xmqqa9ho2i6v.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
	<CAMP44s39H8tASO_OvK+C+XSG-2pm09RJY6Xeg4AqDZBAU7GPaw@mail.gmail.com>
	<xmqqfvrh5kev.fsf@gitster.dls.corp.google.com>
	<xmqqppqk2n3d.fsf@gitster.dls.corp.google.com>
	<CAMP44s1wfk3zmiof6E474vNi72zTo_QFj=56G3POjopukGK-5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 17:36:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcHhe-0008SK-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 17:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab3KAQf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 12:35:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524Ab3KAQf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 12:35:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 810F34D7E9;
	Fri,  1 Nov 2013 12:35:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PPOESXG5JMAOWpoqDz3lyUvk+U=; b=BYBom0
	PQLi28D2igyHetIjMVEj/6A595Ejhpyp+l/FumdJJ8QAD5er6BBgnqixSAUNgOSi
	y2s/9AAGJypLR/l85DX9yY2im3G6miDi/81bXoBAzXk+WF9iTgsjGTsmHJwn+uiW
	5XGUMRT2tP1sHr2tB0nOsJfrMlCJzF35q6hvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GQrNHFDLLO5S4DV/02HFUeOXvsloDFJ5
	be4S7hYdBeNGB7bV1LXDwFr3HczfZW5qSQkRiGZxVv3vhcOpn37VmczW4ZCeMICL
	uF58KhhKJvdwcEJpdegprqTsWda6Xr3HHklI4HvzGGKJ5JE2uD2c7cs3mFvDbbIg
	eZxtyeqEi4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 726794D7E7;
	Fri,  1 Nov 2013 12:35:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEC0A4D7E5;
	Fri,  1 Nov 2013 12:35:54 -0400 (EDT)
In-Reply-To: <CAMP44s1wfk3zmiof6E474vNi72zTo_QFj=56G3POjopukGK-5Q@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 1 Nov 2013 09:37:14 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ADAE2E9E-4313-11E3-8B5F-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237215>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Nov 1, 2013 at 8:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Because updated helpers know 'force' option, such a s/die/warning/
>> change would not affect them at all.
>
> Yeah, that makes sense.

OK, then let's queue this separately on top, so that we can revert
it more easily when our "s/die/warning/ should be safe and more
friendly to existing users" reasoning we discussed is found to be
faulty later.

-- >8 --
Subject: [PATCH] transport-helper: demote lack of "force" option to a warning

It would have been a good conservative position to take, if there
were no existing helpers, to die when the user asked to force a push
through a transport helper mechanism and the helper script hasn't
been updated to handle the "force" option.

There however are existing helpers in the field and none of them
obviously has been taught about the option yet.  If a helper has not
been updated to understand "force", but the user has happily been
accepting the result of "git push $there +master" (perhaps because
he has never pushed a non-ff history so far), the change made
previously in this series will fail the push, which would be a minor
regression for such a user.

Demote lack of "force" option from a "die()" to a "warning()".  By
doing so, such a user now gets a warning that notifies him that his
push has been working by accident, even when the particular ff-push
that showed the error message goes through successfully.

If his push does need "force", he gets the same old behaviour,
possibly a broken one, out of the helper that has not been update,
but again he does see the warning.

Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index ef91882..6b167ea 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -862,7 +862,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (flags & TRANSPORT_PUSH_FORCE) {
 		if (set_helper_option(transport, "force", "true") != 0)
-			die("helper %s does not support 'force'", data->name);
+			warning("helper %s does not support 'force'", data->name);
 	}
 
 	helper = get_helper(transport);
-- 
1.8.5-rc0-205-g5b7460b
