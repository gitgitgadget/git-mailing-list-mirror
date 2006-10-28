X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: fetching packs and storing them as packs
Date: Sun, 29 Oct 2006 00:31:10 +0200
Message-ID: <4543DA2E.9030300@tromer.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 22:33:10 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <20061028072146.GB14607@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30401>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdwjc-0002gB-Dm for gcvg-git@gmane.org; Sun, 29 Oct
 2006 00:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964899AbWJ1Wbq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 18:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWJ1Wbq
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 18:31:46 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:36031 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S964899AbWJ1Wbq (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 18:31:46 -0400
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.7/8.12.11) with ESMTP id k9SMVTaB003629; Sun, 29 Oct 2006 00:31:32
 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi Shawn,

On 2006-10-28 09:21, Shawn Pearce wrote:
> Lets say that a pack X is NOT eligible to be repacked if
> "$GIT_DIR/objects/pack/pack-X.keep" exists.
> 
> Thus we want to have the new ".keep" file for historical packs and
> incoming receive-pack between steps c and g.  In the former case
> the historical pack is already "very large" and thus one additional
> empty file to indicate we want to retain that pack as-is is trivial
> overhead (relatively speaking); in the latter case the lifespan of
> the file is relatively short and thus any overhead associated with it
> on the local filesystem is free (it may never even hit the platter).

Sounds perfect.

It would be nice to have whoever creates a pack-*.keep file put
something useful as the content of the file, so we'll know what to clean
up after abnormal termination:

$ grep -l ^git-receive-pack $GIT_DIR/objects/pack/pack-*.keep


