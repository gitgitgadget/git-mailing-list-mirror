From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/32] refs: move resolve_ref_unsafe into common code
Date: Wed, 24 Feb 2016 16:22:10 -0800
Message-ID: <xmqqmvqpr64t.fsf@gitster.mtv.corp.google.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	<1456354744-8022-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:22:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjhB-0003Te-DW
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337AbcBYAWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:22:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755438AbcBYAWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:22:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFFEA48746;
	Wed, 24 Feb 2016 19:22:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n2ZZBC4O2nGBr3oIVwH1/r1Kw7g=; b=gp6Yq6
	lkiqLtk5Jltv9fiTjoTZj6MrPPatRy/vTMkVvQ+vNpCi0lsPSshFq3PXbkwOP/eZ
	8jnjn8Y/LUeG46yNDKp8Siue5StkG9hwCrohyKhr0U2PL2O3zKStmt1liWUbRj3c
	jhVgLkzmKOJsyY4B080p+X9O+eYS2TLISKVQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCFU6SiOi1TcKSEX83nzs1IU49ND/92e
	3jckreaD0wuL4QmeMByQwf242YL3QUjbB4h9uM00zuhPuhp6mVK5MlH9mFEDIR7V
	deX2NE7y9V9MNSoPj123tp8CgnVKy7C2EVIXpPM4tUjsQdisNsoTEETeKbqDetow
	dukhe1Fbdj4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5D0F48745;
	Wed, 24 Feb 2016 19:22:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 48D7248741;
	Wed, 24 Feb 2016 19:22:11 -0500 (EST)
In-Reply-To: <1456354744-8022-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Feb 2016 17:58:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0010D2C-DB55-11E5-9383-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287292>

David Turner <dturner@twopensource.com> writes:

> +	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
> +		int read_flags = 0;

Continuing from the previous one, this becomes "unsigned int".
