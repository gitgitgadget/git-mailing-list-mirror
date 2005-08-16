From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Add merge detection to git-cvsimport
Date: Tue, 16 Aug 2005 13:07:25 +0200
Message-ID: <20050816110725.GL11882MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <20050816103527.F420A33010C@ng.eduforge.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 13:02:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4zC8-0008Pi-P6
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 13:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVHPLBT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 07:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVHPLBT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 07:01:19 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:37533 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S932236AbVHPLBT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 07:01:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 6D03C137B92
	for <git@vger.kernel.org>; Tue, 16 Aug 2005 13:01:14 +0200 (CEST)
Received: from smtp01.kuleuven.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 9FD52137AED
	for <git@vger.kernel.org>; Tue, 16 Aug 2005 13:01:13 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by smtp01.kuleuven.be (Postfix) with ESMTP id 89DA063D45
	for <git@vger.kernel.org>; Tue, 16 Aug 2005 13:01:13 +0200 (CEST)
Received: (qmail 7176 invoked by uid 500); 16 Aug 2005 11:07:25 -0000
To: Martin Langhoff <martin@ng.eduforge.org>
Mail-Followup-To: Martin Langhoff <martin@ng.eduforge.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050816103527.F420A33010C@ng.eduforge.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 16, 2005 at 10:35:27PM +1200, Martin Langhoff wrote:
> +
> +sub get_headref($$) {

If you want to check whether a ref is valid, then
it is better to use git-rev-parse...

> +    my $name    = shift;
> +    my $git_dir = shift; 
> +    my $sha;
> +    
> +    if (open(C,"$git_dir/refs/heads/$name")) {
> +	chomp($sha = <C>);
> +	close(C);
> +	length($sha) == 40
> +	    or die "Cannot get head id for $name ($sha): $!\n";

... but if you're just going to die, then why not simply
let git-commit-tree do the test ?

> +				if ($mparent eq 'HEAD') { $mparent = 'origin'};

Please don't hardcode 'origin' here.

skimo
