From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 6/7] git-p4: add support for large file systems
Date: Wed, 16 Sep 2015 10:59:56 -0400
Message-ID: <20150916145956.GA515@flurp.local>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
 <1442237194-49624-7-git-send-email-larsxschneider@gmail.com>
 <55F92A1E.1090002@diamand.org>
 <5329966D-1A0C-42A1-9099-AC449D50AA52@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 17:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcEBv-0002DV-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 17:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbbIPPAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 11:00:03 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34924 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbIPPAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 11:00:02 -0400
Received: by ioiz6 with SMTP id z6so232272710ioi.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KIZo+Gc5YkW6E8ZfHWp3X7eAv6hmLE+ysEolXxBEd50=;
        b=Z1CNrS4kMZ+4XBvHlawBQM2OTPvLbS0mzCnHtSLbvWOUsWAKPfOE9le8f4XGB9tTfb
         yBpw0sJhPHvE/zYR3IAHWMaaZrNlrY6S4YbxAI4v6lW5jY4qO4yYNzOjmvlagXEyx2Hr
         k6JR9D680ztB5oaTH+Vye2RqOSot0/sGc9naASiM6frEZ3jXQZKgF5phOwAtEHg+qAA4
         wmMWATSof1hl+AEkzYh7qm61ECILfxPd5bgEaB4ymNKGosQ/oo1Vbge5WhfP3RRaaF5h
         RTrKQjRh3rE0LRs0WYhKCrOlIF4f8j5DoKZCaApMpxL2fWbIv6AJVEvUKXZJmTKTSgL8
         NX9A==
X-Received: by 10.107.152.75 with SMTP id a72mr32066073ioe.129.1442415601191;
        Wed, 16 Sep 2015 08:00:01 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id au6sm46778igc.0.2015.09.16.08.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 08:00:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5329966D-1A0C-42A1-9099-AC449D50AA52@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278028>

On Wed, Sep 16, 2015 at 02:05:40PM +0200, Lars Schneider wrote:
> On 16 Sep 2015, at 10:36, Luke Diamand <luke@diamand.org> wrote:
> > On 14/09/15 14:26, larsxschneider@gmail.com wrote:
> >> +test_file_in_mock () {
> >> +	FILE="$1"
> > Missing &&
> > Plus the next few lines
> Are they strictly necessary? I believe you can define variables all
> in ?one line?. I found it like that in existing tests:

The reason for keeping the &&-chain intact even on these variable
assignment lines is to future-proof it against some programmer coming
along and inserting new code above or in between the assignment
lines, and not realizing that the &&-chain is not intact.
