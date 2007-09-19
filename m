From: David Brown <git@davidb.org>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Wed, 19 Sep 2007 12:14:12 -0700
Message-ID: <20070919191412.GA6475@old.davidb.org>
References: <119022570352-git-send-email-git@davidb.org> <200709192103.53526.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY507-0007Uv-0a
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 21:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbXISTOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 15:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbXISTON
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 15:14:13 -0400
Received: from mail.davidb.org ([66.93.32.219]:57631 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbXISTON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 15:14:13 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IY500-0001kO-Pj; Wed, 19 Sep 2007 12:14:12 -0700
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200709192103.53526.simon@lst.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58726>

On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
>On Wednesday 19 September 2007 20:15:03 David Brown wrote:
>> git-p4 was missing the execute bit setting if the file had other attribute
>> bits set.
>> ---
>>  contrib/fast-import/git-p4 |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
>> index adaaae6..50850b8 100755
>> --- a/contrib/fast-import/git-p4
>> +++ b/contrib/fast-import/git-p4
>> @@ -932,7 +932,10 @@ class P4Sync(Command):
>>                  data = file['data']
>>
>>                  mode = "644"
>> -                if file["type"].startswith("x"):
>> +                if (file["type"].startswith("x") or
>> +                        file["type"].startswith("cx") or
>> +                        file["type"].startswith("kx") or
>> +                        file["type"].startswith("ux")):
>>                      mode = "755"
>>                  elif file["type"] == "symlink":
>>                      mode = "120000"
>
>I'm fine with this, so unless you find a better way:

Well, I just tested it, and it still doesn't work, so I need to take some
time and try to figure out what is happening.

I'm sometimes getting back 'xtext', and sometimes things like 'text+mx'
back from perforce, so I need to read up, and really figure out what to
look for.

David
