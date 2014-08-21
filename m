From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/4] Handling unmerged files with merged entries
Date: Thu, 21 Aug 2014 20:40:47 +0200
Message-ID: <53F63D2F.9060704@kdbg.org>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>	<cover.1408533065.git.jsorianopastor@gmail.com> <xmqqr40ast2g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 20:40:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKXI9-0002Se-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 20:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbaHUSkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 14:40:53 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:48478 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753939AbaHUSkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 14:40:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CEAFB130083;
	Thu, 21 Aug 2014 20:40:49 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A99F019F45C;
	Thu, 21 Aug 2014 20:40:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <xmqqr40ast2g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255630>

Am 21.08.2014 00:19, schrieb Junio C Hamano:
> For that, we need to catch an index whose entries are not sorted and
> error out, perhaps when read_index_from() iterates over the mmapped
> index entries.  We can even draw that "hopelessly corrupt" line
> above the breakage you are addressing and add a check to make sure
> no path has both merged and unmerged entries to the same check to
> make it error out.

Except that we can't declare an index with both merged and unmerged
entries as "hopelessly corrupt, return to sender" when it's dead easy to
generate with the git tool set:

 >x
 name=$(git hash-object -w x)
 for i in 0 1 2 3; do printf '100644 %s %d\tx\n' $name $i; done |
 git update-index --index-info

-- Hannes
