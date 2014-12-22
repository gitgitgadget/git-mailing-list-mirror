From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in
 t0090-cache-tree
Date: Mon, 22 Dec 2014 14:02:09 -0800
Message-ID: <20141222220209.GT29365@google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
 <xmqqk31j8ik9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bdwalton@gmail.com>, dturner@twopensource.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:02:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3B3R-0005l0-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbaLVWCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:02:13 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61779 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbaLVWCN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:02:13 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so4933467ier.6
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 14:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=seH7ZI3yB82B/BaOUZMx0YyKou3nr4d61poDGiwn1UE=;
        b=Qvo7LtgnCFlkDBvcjROhCtSfyoG8Fi6gEKJazfJFfltINCoXxw4/F1MlHJGo8ZOMO/
         k7RxSOi0TIdkrq5POM3E+td+LpFZUoU0GQxXAJNen2zNByS+m1t1EqllIGCVNp2QWK9S
         uHKUFJEkIzwQmtg7B5GV88BbJVHot+d6L6+gmRHqUgh4/ihzdQpKH55ZKt3m60yaMQwG
         V/wNf6Fufh/Noi2CSbHI6tnXKNfqCKtOlNbPjjiMq4pe8WAU9p6rHfXJoD5gHGInIVBw
         DRgSPDaKTxNQK47Ld/7M5jys/IldQUvuh7t3b5XjmC8gHvCEHZYNIRv+o2q7bWetHx6U
         d+Hg==
X-Received: by 10.50.103.41 with SMTP id ft9mr17996437igb.6.1419285732247;
        Mon, 22 Dec 2014 14:02:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d0f3:eebb:4e13:baf])
        by mx.google.com with ESMTPSA id t15sm9044584ioi.21.2014.12.22.14.02.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Dec 2014 14:02:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqk31j8ik9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261680>

Junio C Hamano wrote:
> Ben Walton <bdwalton@gmail.com> writes:

>> echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
>> 0
>>
>> And with GNU awk for comparison:
>> echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
>> 1
>>
>> Instead of modifying the awk code to work, use wc -w instead as that
>> is both adequate and simpler.
>
> Hmm, why "wc -w" not "wc -l", though?  Is somebody squashing a
> one-elem-per-line output from ls-files onto a single line?

The old code was trying to skip empty lines.
