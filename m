From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue, 03 May 2016 15:28:40 -0700
Message-ID: <xmqqy47qkc87.fsf@gitster.mtv.corp.google.com>
References: <1462313499-6760-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	cederp@opera.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:28:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axioB-0006Ga-OD
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbcECW2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:28:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756519AbcECW2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3711A18DA6;
	Tue,  3 May 2016 18:28:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=veqX9m5HTr73wR2tV2i+dnEDQII=; b=M5j3o+
	TgtFxc0bNGNNCCvO1LFOuCse1IG6wFdkN2CtYxQbHoQ2bfx+x5V6M7KMMkzavmwx
	RtwQNfgdSX799GAZ3SHts/CuE8PklRGXnP+A14xAADzL4zWZDeLUw+9K/FnDggrf
	7RFvwAQ4sj5E/FWag/dyBj/mTxBEikJy9fwCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y2g5c1aIdsrsYgOQxfvj1huseWPR7dlx
	YTZ+c0+2CZa+Em7N6+98LOBg3kCDjHxEQR8xPYI1md0phRq/25jF/zj/Y0UoAYmI
	rquyPlhUvgL1w5Ts7wSeWp1kOgJlvjEkbxsfmifa4SQ76fnqjWtDQrl9K9Bb4Iyj
	Ctee/978onk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EBC318DA5;
	Tue,  3 May 2016 18:28:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B3D218DA3;
	Tue,  3 May 2016 18:28:41 -0400 (EDT)
In-Reply-To: <1462313499-6760-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 3 May 2016 15:11:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63A1F3BC-117E-11E6-8E3F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293469>

Stefan Beller <sbeller@google.com> writes:

> I developed it on top of 
>     "submodule deinit test: fix broken && chain in subshell"
>     on top of 2a4c8c36a7f6, 2016-03-24, Merge branch
>     'sb/submodule-module-list-pathspec-fix'
> but I think this would rather go in as a new feature, not on top
> of a bugfix topic, so I think this could go on origin/master ?

I do not particularly view it as a new feature.  The way the old
message suggested did not work in a pathological corner case, but we
wanted to keep the "force user to be explicit when doing mass
destruction", and a fix we happened to chose requires addition of a
new option--that would still look like a fix to me.

It is not like we are forbidding the use of "submodule deinit ."
that used to work in a tree with at least one tracked path.  With
the change, a script that has such a command will continue to work,
no?
