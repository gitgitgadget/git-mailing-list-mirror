From: Di Xu <xudifsd@gmail.com>
Subject: Re: BUG - git clean
Date: Sat, 12 Oct 2013 10:36:39 +0000 (UTC)
Message-ID: <loom.20131012T122854-19@post.gmane.org>
References: <52584914.6030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 12:45:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUwhQ-00061o-Ax
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 12:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836Ab3JLKpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 06:45:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:37606 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab3JLKpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 06:45:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VUwgx-0005im-0C
	for git@vger.kernel.org; Sat, 12 Oct 2013 12:45:12 +0200
Received: from 223.64.60.59 ([223.64.60.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 12:45:02 +0200
Received: from xudifsd by 223.64.60.59 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 12:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 223.64.60.59 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236046>

> mkdir test
> cd test
> git init .
> mkdir ba
> mkdir ba/ca
> 
> # So far so good.
> # Should clean directory "ba/ca"
> git clean -dn -- ba/ca
> 
> # Should clean "ba/ca" and ignore non-existent "j"
> # Instead, it wants to delete "ba" totally.
> git clean -dn -- ba/ca j

actually, my git will also do it wrong when 'j' exist, do
these after your script:

$ git clean -dn ba/ca j
Would remove ba/
$ mkdir j
$ git clean -dn ba/ca j
Would remove ba/ #here missing 'ca'
Would remove j/

I think it's the problem of directory path manipulation.
