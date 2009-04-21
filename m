From: Teemu Likonen <tlikonen@iki.fi>
Subject: Bug in colored "log --graph" implementation
Date: Tue, 21 Apr 2009 16:36:10 +0300
Message-ID: <87zlea9lit.fsf_-_@iki.fi>
References: <alpine.DEB.1.00.0904211010410.10279@pacific.mpi-cbg.de>
	<20090421124701.GA25982@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 15:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwGAj-0005ff-RC
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 15:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZDUNgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 09:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbZDUNgR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 09:36:17 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:58590 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbZDUNgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 09:36:16 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 49CA1E730120D74F; Tue, 21 Apr 2009 16:36:12 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LwG8w-0002KJ-2K; Tue, 21 Apr 2009 16:36:10 +0300
In-Reply-To: <20090421124701.GA25982@linux.vnet> (Allan Caffee's message of "Tue\, 21 Apr 2009 08\:47\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117130>

The colored log graph implementation (commit 427fc5b) introduces an
alignment bug which looks like this:


| | * | edf2e37 git-apply: work from subdirectory.
| | * | 4ca0660 working from subdirectory: preparation
| |  | |        
| |   \ \       
| |    \ \      
| |     \ \     
| |      \ \    
| |       \ \   
| *-----. \ \   5401f30 Merge branches 'jc/apply', 'lt/ls-tree', [...]
| |\ \ \ \ \ \  
| | | | | * | | 0501c24 Tutorial: adjust merge example to recursive [...]


In other words, the diagonal lines after this octopus merge are aligned
wrong. To see it yourself type

    git log --graph --oneline a957207

in the Git repository and scroll the output down a bit. Note that the
bug exists with both --color _and_ --no-color.
