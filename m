From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 06 Dec 2011 11:10:37 -0800
Message-ID: <7vd3c1h5xu.fsf@alter.siamese.dyndns.org>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <CACsJy8CZjrKpv53Ep8ietAHAeVW4bnYeXTa6x5FGncT1HXGWQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 20:10:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY0Pf-0004Hn-7O
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 20:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab1LFTKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 14:10:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930Ab1LFTKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 14:10:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D415B48;
	Tue,  6 Dec 2011 14:10:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=87ZYzwQqgAL+r8fGS640eiffDr0=; b=dBQBlx
	VOksR5ltLodMoJIeEUlH14hyOUlTL3q3IK8OE2QzDCvPEVILojA107hlfaHpWDt6
	6FQDALLgPBNVV383x4zyS1UT+LHs27q3eWc1WykkgTNGpOzP94NrNIgjcUGwh5kf
	Vtg1A0w9NZFzNp0nLmshdUKKGQF4/Ky8lS3Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ee2BQeyzdkXcyoQNH6Z8wOymCPiVR1yg
	zR815zNdY/DW9z6xeLGK4vDjuQW5o7pyhtZwl+7AU6NTBb8uGUT+ejmH6X90kXSI
	iPZWbi/shjtDCbqDhITjbBHtJi5be9fljDiBuzr/CPqt+/VtdgKEBCn46ZLXj+Fy
	LIAIjuj2PIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E17BE5B47;
	Tue,  6 Dec 2011 14:10:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74FB65B45; Tue,  6 Dec 2011
 14:10:39 -0500 (EST)
In-Reply-To: <CACsJy8CZjrKpv53Ep8ietAHAeVW4bnYeXTa6x5FGncT1HXGWQg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 6 Dec 2011 18:20:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC3EE03A-203D-11E1-A371-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186371>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> What can I do to get "build in repack" [1] series in or moved forward?

Resubmit to re-ignite interest in reviews, perhaps?

As long as it is done right at the implementation level, I do not think
there is anything controversial in the desired end result, iow it is not
like we need three people who want to have repack rewritten in C for it to
happen.

It may be tricky to get the flushing of old and new packfiles right,
though.

Use of reprepare_packed_git() is prerequisite if you want to do it in a
single process, but once you start using that API, it may not gain much
performance benefit to link the whole pack-objects logic in to the process
over a much simpler and less error prone approach of just rewriting the
shell script straight to a small C program that spawns pack-objects
binary.
