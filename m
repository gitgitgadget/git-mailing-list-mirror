From: Patrick Hemmer <git@stormcloud9.net>
Subject: Set file modification time on checkout
Date: Wed, 12 Nov 2014 23:45:52 -0500
Message-ID: <54643780.7060504@stormcloud9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 05:45:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XomIA-0000xM-Dv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 05:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbaKMEpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 23:45:54 -0500
Received: from ec2-54-241-211-23.us-west-1.compute.amazonaws.com ([54.241.211.23]:42029
	"EHLO feystorm.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753559AbaKMEpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 23:45:54 -0500
Received: from [192.168.0.24] (thirteen.feystorm.net [192.168.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by feystorm.net (Postfix) with ESMTPSA id 96D5A191BED8
	for <git@vger.kernel.org>; Wed, 12 Nov 2014 23:45:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The request is to allow git to set the file modification time on
checkout to the commit-author-date of the commit which last modified the
file.
Yes I know this is in the FAQ, but the FAQ entry is missing an
increasingly common use case: docker.
When docker builds an image, it generates layers of images based on each
build step. Adding a file would be a build step, and for this action it
generates a hash based on the file modification time & content. Next
time the image is built, if these haven't changed, the previously built
layer is reused. And like git commit history, if a layer changes, the
hash of all subsequent layers change and have to be rebuilt. So reusing
layers can save a ton of time.

Now I'm not proposing that this be made the default action. The `make`
use case is legitimate. But it would be nice to have an option for
`checkout` and `reset` which toggles the behavior.

-Patrick
