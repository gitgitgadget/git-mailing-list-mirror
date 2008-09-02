From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/2] Move call_depth and index_only to struct merge_options
Date: Wed,  3 Sep 2008 00:05:31 +0200
Message-ID: <cover.1220392547.git.vmiklos@frugalware.org>
References: <7v1w02l3jc.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:06:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kae1O-00039s-16
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbYIBWFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbYIBWFj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:05:39 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47073 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYIBWFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:05:38 -0400
Received: from vmobile.example.net (dsl5401C449.pool.t-online.hu [84.1.196.73])
	by yugo.frugalware.org (Postfix) with ESMTP id E9BCC1DDC5C;
	Wed,  3 Sep 2008 00:05:35 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 0B27E84CB; Wed,  3 Sep 2008 00:05:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <7v1w02l3jc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94726>

On Tue, Sep 02, 2008 at 01:02:31PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I found it a bit disturbing that "index_only" and "call_depth" were
> not
> part of merge_options structure.

Here are two patches to do it, on top of current mv/merge-recursive.

Both patches are pretty trivial, I think, but I split them as the second
one is larger.

Now in some cases we have function calls like

merge_file(o, one, a, b, o->branch1, o->branch2);

but I don't think we can avoid it, as the last two parameters are not
always like this (two times are like this, and once conditionally
swapped). I'm not sure if it worth to introduce a new "int swap"
parameter, just to avoid the last two one.

Miklos Vajna (2):
  merge-recursive: move call_depth to struct merge_options
  merge-recursive: move index_only to struct merge_options

 merge-recursive.c |  164 ++++++++++++++++++++++++++---------------------------
 merge-recursive.h |   13 ++++
 2 files changed, 93 insertions(+), 84 deletions(-)
