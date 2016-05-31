From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG] git-submodule has bash-ism?
Date: Tue, 31 May 2016 16:08:03 -0700
Message-ID: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 01:08:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7slh-0000Jl-9m
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbcEaXIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:08:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbcEaXII (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:08:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDF5F20603;
	Tue, 31 May 2016 19:08:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	pQ2g3k0OA4bAkEtvokWQRdrElo=; b=wYwJ9ErlVxbsxg5hznoZOphcJRRJot0MX
	h2IGo2+57HoByQdejWoop6kv/qboKL6FJNDhya+QCLN7FIGzP2RHqYtOrgPrBPsM
	IMdPI3NdjS4m7NrkEaf1F3nQBtB6FYUzQYYrFp2+7gVfEcNnZSCle28IREoZOI05
	CHqLsYGYUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=tdx
	oKlVyCcGwZRueJk5gRxgt9fdblIYRsCUUKRHwgLlzmDxBtayOscvGEAGrK8xJPdC
	DJaPlGLFPQXN4sejo3l21jWTi2/EsC273ahFd+MKOUFQ0W6mtKBrPE0d2hbQXHdh
	V4p9kz3vorTgPUbPJYQv1FwJ70nqdeHzTMrq5Dt0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E528F20602;
	Tue, 31 May 2016 19:08:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FE9F20601;
	Tue, 31 May 2016 19:08:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88254808-2784-11E6-BE6E-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296033>

relative_path ()
{
	local target curdir result
	target=$1
	curdir=${2-$wt_prefix}

I am hoping that Stefan's "gradually rewrite things in C" will make
it unnecessary to worry about this one.  "git submodule" would not
work correctly on posixly correct shells in the meantime.
