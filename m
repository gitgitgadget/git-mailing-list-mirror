From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git fetch -v not at all verbose?
Date: Thu, 21 Jan 2010 08:18:58 -0800
Message-ID: <20100121161858.GC19078@spearce.org>
References: <20100121004756.GA18213@onerussian.com> <20100121050850.GA18896@Knoppix> <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121155136.17b59e8f.rctay89@gmail.com> <20100121140054.GH18213@onerussian.com> <20100121224100.624c9c9d.rctay89@gmail.com> <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org> <20100121161016.GA16300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:19:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzkX-00030t-JO
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab0AUQTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900Ab0AUQTI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:19:08 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56933 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab0AUQTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:19:02 -0500
Received: by yxe17 with SMTP id 17so130705yxe.33
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 08:19:02 -0800 (PST)
Received: by 10.150.94.16 with SMTP id r16mr2307129ybb.201.1264090742203;
        Thu, 21 Jan 2010 08:19:02 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 7sm446950ywf.10.2010.01.21.08.19.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 08:19:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100121161016.GA16300@redhat.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137664>

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> On many of my trees (with linux kernel), git fetch is slower than git clone.
> Even more annoyingly, it would hang sometimes for tens of minutes without any
> output, even if -v is supplied.

Ouch.  I think -v -v boosts the output to be ever more verbose,
and might actually show you something.
 
> stracing it shows a ton of lines like the following:
> 16324 read(10, "ACK 4bbdfe65d23014f539fec4227260"..., 51) = 51
> 16324 read(10, "0037", 4)               = 4
> 16324 read(10, "ACK 322c06560fa314b04a6302ea03c0"..., 51) = 51
> 16324 read(10, "0037", 4)               = 4
> 16324 read(10, "ACK 848ea2043b128b5947851866a114"..., 51) = 51
> 16324 read(10, "0037", 4)               = 4

That's the peers trying to determine a common base.
 
> Is there some way to make got fetch show progress at this stage,
> or even better, can it be made faster somehow?

We shouldn't need to show progress here, we should just be faster.

Given the symptom, it sounds to me like your local repository
is some 1,000s of commits ahead of the remote repository you are
fetching from.  Is that true?

Are you fetching from a configured remote that has tracking branches,
or are you fetching through a one-shot URL pasted onto the command
line?

-- 
Shawn.
