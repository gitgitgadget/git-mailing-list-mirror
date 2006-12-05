X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 12:01:28 +0100
Organization: At home
Message-ID: <el3jeb$gkr$1@sea.gmane.org>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <4570BFA4.8070903@stephan-feder.de> <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com> <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org> <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com> <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org> <e7bda7770612041226j4d4a5584m279afa9a2d7dfe74@mail.gmail.com> <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org> <45754C0E.3070904@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 10:59:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33337>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrY1R-0004SW-3L for gcvg-git@gmane.org; Tue, 05 Dec
 2006 11:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967739AbWLEK7e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 05:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759943AbWLEK7e
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 05:59:34 -0500
Received: from main.gmane.org ([80.91.229.2]:47012 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759940AbWLEK7d
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 05:59:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrY1L-0005e6-1s for git@vger.kernel.org; Tue, 05 Dec 2006 11:59:31 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 11:59:31 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 11:59:31 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:

> Indeed. With the "tight" integration option we'd also have to have the 
> mechanism to rewrite the tree-entries with the location where the 
> submodule is located in the working tree. This might be needed anyways, 
> but it sure as hell seems a lot easier to just tack that part on when 
> doing a checkout and actually creating all the files.

Excellent idea! This way most of the concerns for "separate repositories for
submodules" layout about ability to rename directory the submodule resides
in, or move submodule are resolved. The other part would be to use
submodule-aware git-mv to move submodule(s).

Perhaps the following solution would work best:
 * refs/submodules/<module> holds sha1 of top commit in submodule
 * objects/info/submodules is a file which can be automatically generated
   (or at least automatically updated) on checkout, with the following
   contents:

   <module> TAB or SPC <path to submodule, or GIT_DIR of submodule, or
                        GIT_OBJECT_DIRECTORY of submodule>

   with the usual rule that # and ; means comment, \ at end of line is used
   for continuations, empty lines doesn't matter etc.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

