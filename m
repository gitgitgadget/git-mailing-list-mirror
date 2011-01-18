From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 10:39:55 -0800
Message-ID: <7v8vyikqdg.fsf@alter.siamese.dyndns.org>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
 <201101181744.18139.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Sebastian Hahn <mail@sebastianhahn.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 18 19:40:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfGTU-0003Zu-Oe
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 19:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1ARSkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 13:40:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab1ARSkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 13:40:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 955A729BA;
	Tue, 18 Jan 2011 13:40:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ewmCuTsJAEz21qcf5dnG2xoLdWE=; b=t/M0J2
	O0bo2jEyK2WUz+unmkAH7kn1Bw89ijO9ReD40qRgz38HkRl45whnK1MpFnUnzBRQ
	t94Wdyg6VHYYDfgz2JOC46bKP1szgfgMq2HyXguwWUBJ7ajFBfZSI1FGz88qbt0E
	6H9HO3n36gSTjD23gJuvvYzhYIdM2Z4G7U2ME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=md/Hb/bo/4XGw3e7aebRE3biFZK9esSL
	lOVJNJ448C+khlpFqctkIIfhEdAXRN0mc+BRd0ZQ0Jfx8/ozolbvfGtMVn5unMsu
	JsVabhcZkCs0Fpp8uTTrM6RZ4UnXGjvVLD1AnUnWZZUkMFT+BbBanBNHgxcce38y
	nokJ5mOSF3c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 655DE29B9;
	Tue, 18 Jan 2011 13:40:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CA1629B4; Tue, 18 Jan 2011
 13:40:41 -0500 (EST)
In-Reply-To: <201101181744.18139.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 18 Jan 2011 17\:44\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75DB7B4C-2332-11E0-ABE3-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165210>

Thomas Rast <trast@student.ethz.ch> writes:

>   git log -Squux --pickaxe-all -c -p  # shows merge & combined diff
>
> So it only shows the diff with --pickaxe-all, even though the (only)
> hunk clearly introduced the string.

Isn't it just because unless you ask for -m to get all the pairwise diff
between each parent and the merged child the diff machinery won't kick in
for merge commits?  I didn't check the option defaulting logic, but there
may be something that changes the default setting of "-m" among your
examples.
