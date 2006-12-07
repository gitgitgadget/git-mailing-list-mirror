X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Thu, 07 Dec 2006 14:25:13 +0100
Message-ID: <45781639.1050208@op5.se>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com> <20061206192800.GC20320@spearce.org> <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com> <20061206194258.GD20320@spearce.org> <20061206195142.GE20320@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 13:26:02 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061206195142.GE20320@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33575>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsJGB-0005Yc-SC for gcvg-git@gmane.org; Thu, 07 Dec
 2006 14:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032207AbWLGNZS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 08:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032213AbWLGNZR
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 08:25:17 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:58648 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1032208AbWLGNZP (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 08:25:15 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 3F6AB6BCBF; Thu,  7 Dec 2006 14:25:14 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> 
> Perhaps there is some fast IPC API supported by Qt that you could
> use to run the revision listing outside of the main UI process,
> to eliminate the bottlenecks you are seeing and remove the problems
> noted above?  One that doesn't involve reading from a pipe I mean...
> 

Why not just fork() + exec() and read from the filedescriptor? You can 
up the output buffer of the forked program to something suitable, which 
means the OS will cache it for you until you copy it to a buffer in qgit 
(i.e., read from the descriptor).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
