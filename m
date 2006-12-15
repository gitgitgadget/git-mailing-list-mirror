X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: [RFC] A unique way to express "all" (vs "add vs "update") ?
Date: Fri, 15 Dec 2006 12:38:51 +0100
Message-ID: <elu1cn$k3$1@sea.gmane.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 15 Dec 2006 11:37:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 70
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.11.48.246
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34496>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvBNe-0003yU-BU for gcvg-git@gmane.org; Fri, 15 Dec
 2006 12:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751958AbWLOLh2 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006 06:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWLOLh2
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 06:37:28 -0500
Received: from main.gmane.org ([80.91.229.2]:51250 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751958AbWLOLh1
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 06:37:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvBNO-0005UU-3R for git@vger.kernel.org; Fri, 15 Dec 2006 12:37:20 +0100
Received: from 212.11.48.246 ([212.11.48.246]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15
 Dec 2006 12:37:18 +0100
Received: from t2a2e9z8ncbs9qg by 212.11.48.246 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 12:37:18 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

While I am very happy with the refactorings undertaken with regard to
"git add/git commit" (both for UI and documentation), I am still a
little confused by the different ways I seem to find to express the ide=
a
"I want to add (sort of) all file contents".

To be more specific, I find the following in the current documentation:

git add <dir>
	"adds content from all files under <dir>  directory and its
	subdirectories."
	(as interpreted from the "EXAMPLES" section of the git-add
	man-page)
	(BTW, could this <dir> usage be documented in the SYNOPSIS and
	DESCRIPTION sections (admittedly at a 2nd rank after the
	currently documented usage)  as well as in the EXAMPLES ?
	Besides this reference sections would probably include the
	<dir>/<regexp> usage that I've not mentioned here for the sake
	of simplicity.)
=09
	Moreover, the tutorial documents the typical usage "git add ."

git commit -a|--all
	"automatically stage files that have been modified and deleted,
	but new files you have not told git about are not affected."

Granted, the latter semantics for "all" is not exactly the same as the
former. Nonetheless, I think it would be very nice to only have to=20
memorize one way to express "all".

To this end, I would be very happy with the following:
(X-mas is coming soon, isn't it ;-)  )

git add <dir>
	same semantics

git commit -a|--add <files>
	"adds content from the specified files before committing
	(files that are already tracked have their current content
	staged)"

git commit -a|--add <dir>
	"adds content from all files under <dir>  directory and its
	subdirectories before committing"
	(once again, for simplification of my explanations, I omit the
	<dir>/<regexp> usage here)

git commit -u|--update <dir>
	"automatically stage files that have been modified and deleted
	under <dir>  directory and its subdirectories, but new files you
	have not told git about are not affected."
	(once again, for simplification of my explanations, I omit the
	<dir>/<regexp> usage here)

	(This would allow the typical usage "git commit -u ." which is
	barely longer than the current "git commit -a")

=46or interface completeness, "git commit -u|--update <files>" could al=
so
exist but would probably be of no use.

To sum up, "all" would be consistently expressed with the <dir> syntax.
"git commit -a" would not mean "--all" anymore. Lastly, a distinction
would be made between "--add" and "--update":
- "git commit -add" would have the same semantics as "git add"
- "git commit --update" on the other hand would only affect the files
   already tracked

Thank you for your patient attention.
J=E9r=F4me Lovy
