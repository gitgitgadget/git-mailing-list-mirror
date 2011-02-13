From: xiaozhu <xiaozhu@gmail.com>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 17:45:41 +0900
Message-ID: <4D579A35.1000007@gmail.com>
References: <4D565D3B.7060808@gmail.com> <20110213075337.GA12112@sigill.intra.peff.net> <20110213083137.GB12112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 09:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoXab-0001aI-Dg
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 09:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab1BMIps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 03:45:48 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58277 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab1BMIpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 03:45:46 -0500
Received: by pva4 with SMTP id 4so670825pva.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dFt5BJja//JnRwXpBmiqpbeytbA1u3yEDmxrAwGNAWQ=;
        b=huDZD6xd7E9jxIPlrvG7XuElTYMnLQUcKsF9JkNyzbvRylRoRPveBflRJe7JtdIb/9
         CP8uzKbf53PGW/yhENfHeOl/z+CZrg8fwfqmB+YOflcQxDPybaflEIXxaILcvbGKRYVc
         NxpxOl1ZzTgg8G/hSfd36dIgb6RGOf+gN8Y/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qVqE0WdazccUE9Z0D/N1WUFD0EXXmyWgfBCcDAH95jJ3SlSkWKzFb9nZoj0cmEoixz
         yHGZ5a+rPST0uCsT4FDhZoitwGdMGfDNXUdS4Vc1duzgLmADdAvxDlmSu2puWJcYc6My
         pTccPHUeY0RIdNRemG4J2Fbp6ruwWmbcMXZ6A=
Received: by 10.142.180.18 with SMTP id c18mr2005485wff.176.1297586746285;
        Sun, 13 Feb 2011 00:45:46 -0800 (PST)
Received: from [192.168.11.57] (softbank126036243176.bbtec.net [126.36.243.176])
        by mx.google.com with ESMTPS id b11sm2194725wff.9.2011.02.13.00.45.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Feb 2011 00:45:45 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110213083137.GB12112@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166645>

> Shouldn't we still be generating "one two three", encoding it via
> rfc2047 if necessary, and _then_ deciding if folding is required? Yes,
> individual lines in a multi-line subject are good candidates for
> folding, but don't we need to be checking for and folding long lines
> anyway?

It seems that by rfc2047 there is no multi-line subject spec. A subject
with multi-line will be always conflated to one single line. And also
that if we just generate the subject within multi-line just like the
current implemention, yes, we can modify the git-am to decode it correctly,
but most of the mail client will can not show it correctly.

So it seems that there is only one way that combining the whole first
paragraph to a single line? But it will be a nightmare for some long comment.
