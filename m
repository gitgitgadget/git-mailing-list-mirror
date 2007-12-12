From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Wed, 12 Dec 2007 12:18:46 -0800
Message-ID: <7vk5nj7jkp.fsf@gitster.siamese.dyndns.org>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	<31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	<e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
	<402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
	<31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
	<20071212041002.GN14735@spearce.org>
	<31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
	<20071212052329.GR14735@spearce.org>
	<31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
	<Pine.LNX.4.64.0712121814260.27959@racer.site>
	<31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
	<Pine.LNX.4.64.0712121931050.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 21:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Y3I-0000cv-KA
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 21:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXLLUTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 15:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbXLLUTK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 15:19:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbXLLUTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 15:19:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D65B6E6F;
	Wed, 12 Dec 2007 15:18:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 59E3A6E6B;
	Wed, 12 Dec 2007 15:18:48 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712121931050.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 12 Dec 2007 19:37:45 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68098>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When you select the context menu item "Split Hunk" in the diff area,
> git-gui will now split the current hunk so that a new hunk starts at
> the current position.
>
> For this to work, apply has to be called with --unidiff-zero, since
> the new hunks can start or stop with a "-" or "+" line.
> ...

I still have conceptual problem with this whole thing.  For example,
what does that MEAN to split this hunk from your patch...

> @@ -296,7 +369,7 @@ proc apply_hunk {x y} {
>  	if {$current_diff_path eq {} || $current_diff_header eq {}} return
>  	if {![lock_index apply_hunk]} return
>  
> -	set apply_cmd {apply --cached --whitespace=nowarn}
> +	set apply_cmd {apply --cached --whitespace=nowarn --unidiff-zero}
>  	set mi [lindex $file_states($current_diff_path) 0]
>  	if {$current_diff_side eq $ui_index} {
>  		set failed_msg [mc "Failed to unstage selected hunk."]

... by clicking between the '-' and '+' lines, and apply only one half?

Well, the question was not very well stated.  I know what it means --
remove that old line, without replacing with the corrected/updated one.
The real question is how would that be useful?
