From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: fast-import fails in read-only tree
Date: Thu, 28 Jan 2016 17:17:36 -0500
Message-ID: <jwvfuxhz72e.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 23:18:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOusz-0008Gx-SF
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967370AbcA1WRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 17:17:50 -0500
Received: from plane.gmane.org ([80.91.229.3]:44024 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965255AbcA1WRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 17:17:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aOusn-00082Q-CN
	for git@vger.kernel.org; Thu, 28 Jan 2016 23:17:41 +0100
Received: from 76-10-146-127.dsl.teksavvy.com ([76.10.146.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 23:17:41 +0100
Received: from monnier by 76-10-146-127.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 23:17:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 76-10-146-127.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:ZQdVNIvrul0f2qQoD3D3jbuQIos=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285040>

I recently discovered that "git fast-import" signals an error if used in
a tree to which we do not have write-access, because it tries to create
a "objects/pack/tmp_pack_XXX" file even before starting to process
the commands.

Usually this is not a problem (we'll create new commits and such, so
write-access is indeed necessary), but in my case I was using
fast-import only for its "reading" operations (in order to combine
several inter-dependent "cat-file" operations into a single git
session).


        Stefan
