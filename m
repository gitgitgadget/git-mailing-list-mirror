From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] forbid full fetchspecs in git-pull
Date: Mon, 31 Jan 2011 14:38:07 -0800
Message-ID: <7vhbco4s34.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312255.59841.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Sean Estabrooks <seanlkml@sympatico.ca>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2OB-0005Tp-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660Ab1AaWiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:38:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529Ab1AaWiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:38:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9EBDC4F3D;
	Mon, 31 Jan 2011 17:39:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BSaSF3Yswfgo1n0fEDccciFDH2k=; b=r+8x0y
	Zlb1VTa4o4B29HwJW6cVB+nMRSITLvhPQh+FPRC+ftFS3VIEYGURlytIVCosoDJn
	mf4pofuLjCoCJwrQpbEB4/jBd8Zm81qdBjHPaE2WrFg+UsTJD1Aoi6umS9qX1gX5
	3Skq3xxIZkshpbVj21FryOO7VQtGZcllqzA4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzWDEXMy81xy9J2m/sbKx2bZ/e42G4aV
	djXZ7zNNQkE6lQ8AUA6jkUNyWY48kc3R2XAJfhwovK8sJ6LoG/bW411B65S2wzvE
	G2GCBNKT/btvnY2IRqEgc7OC2gN+66DAx4jl603htBRdLvb8/Lp2Qoy7mv4P624e
	BuK3NXZSgRs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E4FB4F3C;
	Mon, 31 Jan 2011 17:39:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC5C24F3B; Mon, 31 Jan 2011
 17:39:01 -0500 (EST)
In-Reply-To: <201101312255.59841.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 31 Jan 2011 22\:55\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9DD0B7A-2D8A-11E0-8FFE-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165770>

Thomas Rast <trast@student.ethz.ch> writes:

> Proposal:
>
> git-pull inherits the full fetchspec invocation syntax from git-fetch,
> so that you can do e.g.
>
>   git pull origin master:master
>
> usually shooting yourself in the foot in the process.  See e.g.
>
>   http://thread.gmane.org/gmane.comp.version-control.git/130819/focus=130879 [item 1]
>
> Prohibit this invocation, i.e., disallow any second argument to
> git-pull that contains ':'.
>
> History:
>
> I submitted a patch ages ago:
>
>   http://article.gmane.org/gmane.comp.version-control.git/130822
>
> Sean seemed to be the only one in favour of the old behaviour, but I
> was too lazy to push it past him.  (There were some issues with the
> test as well.)

As I summarized in $gmane/135813 I don't think there was any objection
against forbidding "git pull" with refspec with colon.  There indeed was
an interesting tangent topic that was about valid use cases of "git fetch"
with such refspec, but I think this is orthogonal to that issue.
