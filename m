From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Wed, 26 Aug 2009 09:08:52 +0200
Message-ID: <4A94DF84.4050906@viscovery.net>
References: <alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org> <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org> <20090825151424.GJ1033@spearce.org> <20090826021057.GL1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 26 09:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgCd0-0005R9-Uv
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 09:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbZHZHI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 03:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbZHZHI5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 03:08:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2914 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbZHZHI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 03:08:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MgCcm-0008Df-UW; Wed, 26 Aug 2009 09:08:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7D8CB735; Wed, 26 Aug 2009 09:08:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090826021057.GL1033@spearce.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127067>

Shawn O. Pearce schrieb:
>  static void upload_pack(void)
>  {
>  	reset_timeout();
> -	head_ref(send_ref, NULL);
> -	for_each_ref(send_ref, NULL);
> -	packet_flush(1);
> +	head_ref(scan_ref, NULL);
> +	for_each_ref(scan_ref, NULL);
> +
> +	push_advertise("HEAD");
> +	push_advertise("refs/heads/*");
> +	push_advertise("refs/tags/*");
> +	send_refs();
> +

How will this mesh with 'git clone --mirror'? Is the client expected to
ask with 'expand refs/*'?

-- Hannes
