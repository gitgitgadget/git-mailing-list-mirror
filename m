From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Mon, 16 Jul 2007 14:31:36 +0200
Message-ID: <81b0412b0707160531mad35ed4x4c89b2d6c6f5f707@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707160504p52770227l9af66aa750d9efd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 14:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAPjq-0007G1-HS
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 14:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbXGPMbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 08:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbXGPMbj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 08:31:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:50166 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbXGPMbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 08:31:39 -0400
Received: by ug-out-1314.google.com with SMTP id j3so964716ugf
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 05:31:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UH1VdDMyKJ5FDNreAwJxROIHXqf5N3Sb3N3gxOLzFB8kYSK140poL4FOCokIQUgwUZQ3IquztUSIwrq+A7vz9RYPapCG1y48x3SvNX4jdsNhau+xYYv6CWtdxlR2NBm9KwYX0KLWvMBOFxnp+DKz2v2Fkf5oEse+kEcPosuhDuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsCosTESGhfP7/QVnysIhoeX9BCigQtDXHGtcrmtVBN8LhzjfD9hTKojtL2INhuG0+pn5m1qSWBzZ6LkQC7ebAjqRbEdrlJoh350zDchyJM6Y1mpzLAM3EfCB5iZGv2V0DCEJsnhRMEdhVjyurf+GGSGBviaKVHFRZFYMXlA+uk=
Received: by 10.78.159.7 with SMTP id h7mr1164715hue.1184589096858;
        Mon, 16 Jul 2007 05:31:36 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 16 Jul 2007 05:31:36 -0700 (PDT)
In-Reply-To: <e5bfff550707160504p52770227l9af66aa750d9efd6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52666>

On 7/16/07, Marco Costalba <mcostalba@gmail.com> wrote:
> Currently the patch just include the log message because the diff
> content (-p option) is not buffered but is written with a combination
> of printf, puts, fputs, fwrite and putchar directly to stdout.
>
> My question is, there is a way to get the quantity of bytes written to
> stdout before they are printed? I'm not an expert of C stdio library,
> so perhaps this is nonsense, but I was thinking of reading the size of
> stout buffer before to fflush() (I don't know if it is possible).

It is not possible. Buffers can be flushed at any time (i.e. they are
flushed when EOL reached and the output is a terminal for stdout).

It is also a bit unclear _why_ do you need the diff output. You don't
show it immediately anyway.
