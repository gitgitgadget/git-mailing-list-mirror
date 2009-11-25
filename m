From: Jed Brown <jed@59A2.org>
Subject: Re: git send-email --notmuch expr
Date: Wed, 25 Nov 2009 14:06:47 +0100
Message-ID: <87aaya69eg.fsf@59A2.org>
References: <87d4375ne0.fsf@59A2.org> <m3hbsic3l5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 14:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDHZg-00068Z-QU
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 14:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934660AbZKYNGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 08:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934657AbZKYNGL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 08:06:11 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45373 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934655AbZKYNGK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 08:06:10 -0500
Received: by bwz27 with SMTP id 27so6874729bwz.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :in-reply-to:references:date:message-id:mime-version:content-type;
        bh=c+Q+OgZ2puLVj1+2ewDgg9bJ0orbOfdZcVdcnkWIAqY=;
        b=NOIBTB1FWGrUr++Vi1b1fXP5GXYKO4bzEX/W1dTSYmmp7FyXin+9/DBdKMzCoWnACk
         7o6KZXhoOma/b8TkmxmiOyP6JgzgFcgKnEVrs6/7cXn3hzAX0RjZrlthweI3a+kSKm98
         l6yl1fovNtWvA2dQxoPWAMAAKdvoD2qct4+OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-type;
        b=vns2gzFIhO0HSwsFxW3xzh93IhgrpQyGiPng3gaHDjY06YXSe7B+SNQf6yqIquDy4f
         /N9Nya+DAaZnLuPpxQlpYqJf9ZjuPSEOqODgAsIOux+VjDsc6dEStagOeMcXUwhmhF+4
         e2Oog0J8LOsbv/DQvHLKyE9COJPBw2W2n9HFs=
Received: by 10.204.7.195 with SMTP id e3mr7462405bke.118.1259154375322;
        Wed, 25 Nov 2009 05:06:15 -0800 (PST)
Received: from kunyang (vawpc43.ethz.ch [129.132.59.11])
        by mx.google.com with ESMTPS id e17sm8583655fke.53.2009.11.25.05.06.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 05:06:14 -0800 (PST)
In-Reply-To: <m3hbsic3l5.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133636>

On Wed, 25 Nov 2009 02:16:52 -0800 (PST), Jakub Narebski <jnareb@gmail.com> wrote:
> (?: ... ) is in Perl non-capturing grouping

Thanks.  Actually that code only executes under --compose, the headers
provided by format-patch all just come through untouched (but all the
interesting ones are duplicated).  So it looks like we just need to
actually parse the relevant headers from format-patch, before the part
where the user gets prompted.  These are a little harder because they
can span multiple lines.  The current validation with --compose is a bit
broken: suppose the user sets the perfectly valid header

To: foo@example.com,
    bar@example.com

The validation will strip the first line while issuing warning, but
send the second through untouched.

Jed
