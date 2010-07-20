From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 20 Jul 2010 07:31:59 +0100
Message-ID: <1279607519.3534.14.camel@dreddbeard>
References: <20091230065442.6117@nanako3.lavabit.com>
	 <201007181355.36691.jnareb@gmail.com> <1279484847.8999.22.camel@dreddbeard>
	 <201007190119.04873.jnareb@gmail.com> <1279523523.3077.8.camel@dreddbeard>
	 <4C448879.4040202@workspacewhiz.com> <1279568744.3009.14.camel@dreddbeard>
	 <4C451272.8000802@workspacewhiz.com>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 08:32:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob6NB-0002mq-C6
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 08:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab0GTGcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 02:32:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46473 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab0GTGcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 02:32:07 -0400
Received: by wwj40 with SMTP id 40so371736wwj.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=/YtZsy5kVtCndqAJhI3E7xhfWpdSnktE5sJCwlcWkR4=;
        b=p8bjAlE2o1Wc6lq9x95sfEjZd2g4UzdtXwmR7qU9H4CVVHMcJHZFKcUiN1mq5SSKnm
         TVvQHJ7C9KFH2WqLhLFgM39pgq34yxBl3WueIqSF6umJ3pIIJZW/rmt6byTteSifQdS4
         GdFN9XFQd7I4rSbCvAvapQSbHOutiymCl+XRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=SY0b6TeqsCPZjCvvyyp+owUtLjOPExEUdTRqrE6ab0/NvCGfDSlvtAZDUNkVmSi3al
         0NcZn7Xe/nbUZjJ6VcCSLgnHz+quTbOZYt3zg2l7SCbPJMWm9iqL2fFt3qH8SbZbY5hD
         lURVuhadOwmyYqtotqp4ajev2Xl8bxx+HtWuc=
Received: by 10.216.159.202 with SMTP id s52mr4768390wek.33.1279607523513;
        Mon, 19 Jul 2010 23:32:03 -0700 (PDT)
Received: from [192.168.0.129] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id e8sm2653996wej.46.2010.07.19.23.32.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 23:32:02 -0700 (PDT)
In-Reply-To: <4C451272.8000802@workspacewhiz.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151305>

On Mon, 2010-07-19 at 21:05 -0600, Joshua Jensen wrote:
> For my sake, how is the previous tip the easiest-to-recover part of a 
> deleted branch?  How do you go about finding the lost object?
> 
> Josh

git fsck | grep '^dangling commit' | while read dangling commit hash; do
	git log -1 --format='%at %h %s' $hash
done | sort -nr | less -FRSX


-- 
-- Will
