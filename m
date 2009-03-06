From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/3] improve bash completion of fetch, pull, and push
Date: Thu,  5 Mar 2009 23:39:30 -0500
Message-ID: <cover.1236314073.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 05:41:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfRsH-0005Oe-5u
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbZCFEj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbZCFEj4
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:39:56 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:60775 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbZCFEjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:39:55 -0500
Received: by yx-out-2324.google.com with SMTP id 8so196369yxm.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 20:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=5YExUwgvhP7JMnqqrMdHhmMfzRkC/FJiyc0bKJlP7mQ=;
        b=N9e2uTwkzE0LtdLrjKXJhNHrTCISmDtQOVEuvJGQZck3pktjmtBZh7zJR9RQTcVnqU
         90DwEJn+NN5iThHa0S76o4g0vcfZuqSqlithUG9jGDK3hNrjajY6bWgEgnX8iUxPrlbl
         bq69o7UjPPSQ7kQyvlRF+MelWDzovnDLPZcyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=bS8FXU8rJE47aRVNtMY9BQA1xpGLPInNCezH0t5Mg0pFan43fcaPYlxRttxwNLrzPL
         v/CMbHP8pddLffLh35tOcvHoG7EUqDetwq9RTLXfadFVhHKFC0H3ghfiwO5F776Ivm8H
         4BVB1jSCNNAFPXUg0PT0/uCFyopTVJFQqMSO0=
Received: by 10.151.84.1 with SMTP id m1mr2482827ybl.50.1236314393702;
        Thu, 05 Mar 2009 20:39:53 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id n29sm1864853elf.10.2009.03.05.20.39.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Mar 2009 20:39:53 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112374>

On Thu, Mar 5, 2009 at 6:15 PM, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> Sverre Rabbelier, 05.03.2009:
>> Heya,
>>
>> Observe:
>> $ git push ori<tab>
>>   git push origin
>>
>> $ git push -f ori<tab>
>>   git push -f origin/
>>
>> Something weird going on there, or is this intentional and am I
>> missing something?
>
> Something similar happens with fetch and pull. They only complete the
> remote name, when exactly 2 words are existing on the command line
> ("git" and the subcommand) by: if [ "$COMP_CWORD" = 2 ]
>
> Doesn't seem right.

This series is intended to fix the original issue, as well as provide
--option completion for all three commands. And, I made a clean spot, so
I had to clean up a couple other things.

Jay Soffian (3):
  bash completion: fix completion issues with fetch, pull, and push
  bash completion: refactor --strategy completion
  bash completion: teach fetch, pull, and push to complete their
    options

 contrib/completion/git-completion.bash |  197 +++++++++++++++++++++-----------
 1 files changed, 130 insertions(+), 67 deletions(-)
