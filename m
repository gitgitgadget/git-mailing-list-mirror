From: "Todd A. Jacobs" <tjacobs@si2services.com>
Subject: Better way to find commit from tarball?
Date: Mon, 6 Sep 2010 15:55:07 -0400
Message-ID: <AANLkTi=ZnZppPu8tT3-sUG6zZM8YnonPwMG_XZhO03up@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 21:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oshme-0007kZ-4M
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 21:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab0IFTzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 15:55:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38556 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0IFTzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 15:55:09 -0400
Received: by wyf22 with SMTP id 22so3351020wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 12:55:07 -0700 (PDT)
Received: by 10.216.157.72 with SMTP id n50mr4079389wek.4.1283802907782; Mon,
 06 Sep 2010 12:55:07 -0700 (PDT)
Received: by 10.216.236.14 with HTTP; Mon, 6 Sep 2010 12:55:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155604>

Someone handed me a tarball that represented an unknown release from a
project. Here's what I came up with to identify the commit:

    cd $SOME_WORK_DIR
    find . -path ./.git -prune -o -print0 | xargs -0 rm
    tar xvfz $TARBALL
    for commit in {0..100}; do
        id="master~${commit}"
        if git diff --quiet --exit-code "$id"
        then
            echo "Matched on commit $id"
            break
        fi
    done

Someone please tell me there's an easier way to find a matching tree
when handed a tarball. This works, but seems cumbersome.
