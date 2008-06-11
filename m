From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Wed, 11 Jun 2008 14:43:06 -0700
Message-ID: <7vr6b3bqc5.fsf@gitster.siamese.dyndns.org>
References: <7vve0hdbvv.fsf@gitster.siamese.dyndns.org>
 <1213183024-60013-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Y76-0002XF-2d
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbYFKVnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbYFKVnV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:43:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYFKVnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:43:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C85E66FDE;
	Wed, 11 Jun 2008 17:43:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 05A206FDA; Wed, 11 Jun 2008 17:43:14 -0400 (EDT)
In-Reply-To: <1213183024-60013-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Wed, 11 Jun 2008 13:17:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 67C3D8CC-37FF-11DD-8625-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84669>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> This adds the --import-marks and --export-marks to fast-export. These import
> and export the marks used to for all revisions exported in a similar fashion
> to what fast-import does. The format is the same as fast-import, so you can
> create a bidirectional importer / exporter by using the same marks file on
> both sides.

Heh, I've long queued a fixed-up version in 'pu' as 4ba0575
(builtin-fast-export: Add importing and exporting of revision marks,
2008-06-05).

I think renaming the "mark_object" to "mark_next_object" makes quite a lot
of sense, and I do not have any preference between mark2deco vs mark_to_ptr 
nor between a macro vs a static inline function for something small like
these.

You still use export_filename and import_filename uninitialized in
cmd_fast_export() and breaks everybody who does not use export-marks
option.  Has this patch (and the previous one I fixed up before queuing it
in 'pu') ever been tested?
