From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 10/21] Free mktag's buffer before dying
Date: Sat, 9 Jun 2007 23:37:26 +0200
Message-ID: <81b0412b0706091437j50070e9aw7c258f136f4d5cde@mail.gmail.com>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	 <200706090210.36270.johan@herland.net>
	 <200706090216.41856.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8cj-0000Gt-8d
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444AbXFIVh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756996AbXFIVh2
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:37:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5838 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794AbXFIVh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:37:27 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1203148ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 14:37:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NUnesboSuXpAdxgrvNLmFfxhIEqYtAFwEtEOE67SQt4p40kloI714ykaieKLJo8rCtNByDJ+YbED1bhr+IdWLtilN6TE8HWzg+rhRU2mOfYFM9zqnpbu34Xxz7wWJpnqWaXD9uj8Sany1g8SOwmp3dHd5vArnZXPisv8UuSVygM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U0SE0cQqZgAXmHp+g2qo2D1uEid/wCpHqa7XvC+U5vWu9tp38KkJAYW86i+v63glKec4Wc/IBGQZr97gKNTFapsZnbnMXYwNMLRAA6QzDQy6J/Z4Aul5vpiXtKPWn0SkJwdTCeSGaIIgovSEAR/6jTf4NAxcvU6j6MihiikdX1Y=
Received: by 10.78.166.7 with SMTP id o7mr1217957hue.1181425046139;
        Sat, 09 Jun 2007 14:37:26 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Sat, 9 Jun 2007 14:37:26 -0700 (PDT)
In-Reply-To: <200706090216.41856.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49623>

On 6/9/07, Johan Herland <johan@herland.net> wrote:
> +       if (parse_and_verify_tag_buffer(0, buffer, size, 1)) {
> +               free(buffer);
> +               die("invalid tag data file");

This, and the similar one below are useless. You're destroying the
process, what do you free that buffer for? Either handle the error
case or do not needlessly complicate your change, which really
also absolutely unneeded.
