From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 12:16:26 -0700
Message-ID: <7vtzesff91.fsf@gitster.siamese.dyndns.org>
References: <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
 <20080714085555.GJ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITYC-0002uX-Hz
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYGNTQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYGNTQe
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:16:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYGNTQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:16:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F24A2B198;
	Mon, 14 Jul 2008 15:16:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E434B2B196; Mon, 14 Jul 2008 15:16:28 -0400 (EDT)
In-Reply-To: <20080714085555.GJ32184@machine.or.cz> (Petr Baudis's message of
 "Mon, 14 Jul 2008 10:55:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E33A244-51D9-11DD-A431-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88450>

Petr Baudis <pasky@suse.cz> writes:

> Getting alternates list for http://repo.or.cz/r/repo.git/
> Getting pack list for http://repo.or.cz/r/repo.git/
> Getting index for pack 5111285cac0f895cd9367c9939ced68e2c43dcc0
> error: non-monotonic index
> /usr/bin/git-fetch: line 297: 30402 Segmentation fault git-http-fetch -v -a "$head" "$remote/"

Yeah, I think git-repack, git-gc, git-pack-objects and git-index-pack on
the server side need a knob to tell it to stay conservative because the
repository may be served over dumb protocols to avoid this problem.

That knob could even be called

	[repack]
        	usedeltabaseoffset = false
	[pack]
        	indexversion = 1
