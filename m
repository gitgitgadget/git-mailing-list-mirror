From: Duy Nguyen <pclouds@gmail.com>
Subject: Lift --stdout restriction for using reachability bitmap in pack-objects?
Date: Tue, 17 Feb 2015 17:07:36 +0700
Message-ID: <CACsJy8AC5ZcsB2_qS4k-+6fJt2_e7m=o8C9UAEcywh=P_4HXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:08:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNf4f-0006SW-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 11:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbbBQKIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 05:08:09 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:47501 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbBQKIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 05:08:07 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so28873084igb.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 02:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=VEn1gz2LMR4/evQ0zSVACCMl1Nkqru3HEw+iCzKWNX8=;
        b=H4GLIhcCFs3oXTQHngssVj4GMYpdGYG8crPS+BPQKMWr/y6HhLXXTxPaqoqo4znvJL
         s3H+Hh6n/vsTLbRt8ew1t0dA4KcijBCZ4x7HfZa1fCCwQvefg/ibdjiW+icM9jx5pH6e
         RPWPTxbZiP5klzLEy2KnlfmajPGYi0vC7K047lptwO4UsL+BWSk8Mq3HV2YYXxLi11hj
         DDj/7OF+K17wrL1LpuEgsBGYk7PEBAkSOEtEjMIgc08BGCCRZo9uypdmuJoU58niSzN0
         Xqj1IjHV9zJttrPF5CrFTGR3FmPyjmp7Bt+yWbWf9FqYe2WrJToPonuC1vI0gLxJECo+
         wLog==
X-Received: by 10.107.30.147 with SMTP id e141mr35684407ioe.17.1424167687135;
 Tue, 17 Feb 2015 02:08:07 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Tue, 17 Feb 2015 02:07:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263939>

Commit 6b8fda2 (pack-objects: use bitmaps when packing objects -
2013-12-21) turns off reachability bitmap optimization if --stdout is
not specified. I wonder if we could lift this restriction?

My use case is debugging pack-objects in gdb (repeatedly) where this
optimization could really save time. But specifying --stdout would
clutter gdb interface.. I don't know this code well enough to judge,
but I think the worst thing is we don't write .idx file out (maybe
because it would involve a lot more work).
-- 
Duy
