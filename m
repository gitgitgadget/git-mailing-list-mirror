From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Sun, 03 May 2015 17:10:51 -0700
Message-ID: <xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>
References: <55463094.9040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 02:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp3yN-000513-LZ
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 02:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbbEDAKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 20:10:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751686AbbEDAKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 20:10:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A982C4F17E;
	Sun,  3 May 2015 20:10:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I5nHyvA9U2ru4XY4Ndobtfg0TRM=; b=uMyVmY
	8fLq/oW+8SWUnWSDuOcB57tFPrkcP4x72VDfhd2h5i6O12eZ5rDMBBAP/9iJ6xuF
	uWh8zNxtxIxrJE3sMZE0IMSYQ0jwZzRwLZGQh9Z3RyeWB21hpxe4THZ8wrMnyZjF
	OjBy7IQZyoRc/oIvb/ShKoClW0wCek+UU5bCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DeDAfnPaItmbfvthpgqGSvnkgrovobC7
	Qs45ja56naliNwktvyjqh9xdJG8ZklRsiWaSRRGGhkdYwhvX+O8CxmZBQdmZPLKL
	xRU/6DzFbuVhiXliENuZ8pdpK+T7/bSv7NQsy1SOyX2RJZbXafj96ObmySU1xTlE
	GfPq+U6lz7A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A027A4F17C;
	Sun,  3 May 2015 20:10:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 253A54F17B;
	Sun,  3 May 2015 20:10:53 -0400 (EDT)
In-Reply-To: <55463094.9040204@gmail.com> (karthik nayak's message of "Sun, 03
	May 2015 19:58:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 071CAC4C-F1F2-11E4-A7F3-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268301>

Hmmmm... you do not seem to pass your own test.

expecting success: 
        echo $bogus_type >expect &&
        git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
        test_cmp expect actual

--- expect      2015-05-04 00:09:24.327335512 +0000
+++ actual      2015-05-04 00:09:24.335335473 +0000
@@ -1 +1 @@
-abcdefghijklmnopqrstuvwxyz1234679
+abcdefghijklmnopqrstuvwxyz123467abcdefghijklmnopqrstuvwxyz1234679
not ok 86 - Type of broken object is correct when type is large
