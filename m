From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: git am and CRLF files
Date: Mon, 16 Nov 2009 08:33:30 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4B01004A.8060600@atlas-elektronik.com>
References: <4AFD2A8F.7000806@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 16 08:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9w64-000888-7g
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 08:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbZKPHdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 02:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbZKPHdq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 02:33:46 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:35865 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZKPHdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 02:33:46 -0500
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 3D8A21389C
	for <git@vger.kernel.org>; Mon, 16 Nov 2009 08:33:48 +0100 (CET)
X-AuditID: 0ac86512-00000094000005bc-65-4b01005c4915
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Nov 2009 08:33:48 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 1DAD427172
	for <git@vger.kernel.org>; Mon, 16 Nov 2009 08:33:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 145842716A
	for <git@vger.kernel.org>; Mon, 16 Nov 2009 08:33:48 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <4AFD2A8F.7000806@atlas-elektronik.com>
X-Enigmail-Version: 0.96.0
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132988>

On 11/13/2009 10:44 AM, Stefan Naewe wrote:
> Hi there.
> I have:
> 
> $ git version
> git version 1.6.5.1.1367.gcd48
> 
> $ git config --get core.autocrlf
> false
> 
> A repository with some UNIX (LF) and some Windows (CRLF) files.
> (and no: I will not change the files. My editors handle CRLF and LF correctly)
> 
> My problem:
> 
> 'git am' can't handle changes in CRLF files because the patch
> gets converted (by git mailsplit) to contain only LF.
> 
> Which is wrong IMHO.
> 
> git-am on my msysgit version looks like this (lines: 214++)
> 
> <---------->
> split_patches () {
> 	case "$patch_format" in
> 	mbox)
> 		case "$rebasing" in
> 		'')
> 			keep_cr= ;;
> 		?*)
> 			keep_cr=--keep-cr ;;
> 		esac
> 		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
> 		clean_abort
> 		;;
> <---------->
> 
> The '--keep-cr' flags is passed to git mailsplit when git am is in 'rebasing' mode.
> By looking through git-am I found that I can pass "--rebasing" to git am to get my
> patch applied correctly.
> But why is git am behaving that way ?
> 
> Puzzled,
> 
> Stefan

Does anyone have any comment on this ?

Regards,

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Microsoft Windows... a virus with mouse support.
