From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: On undoing a forced push
Date: Tue, 09 Jun 2015 20:20:12 +0530
Message-ID: <5576FD24.2040700@gmail.com>
References: <20150609121221.GA14126@lanh> <5576F2DC.7040603@gmail.com> <20150609142550.GB7894@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 16:50:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2KrF-0003Lr-HW
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbbFIOuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 10:50:24 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35133 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbbFIOuU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 10:50:20 -0400
Received: by pdbnf5 with SMTP id nf5so16839926pdb.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=innO/uDp1LnrpovEztv18hoUQMgdNzABsrIZjX94fTM=;
        b=EmjXJJMbAPxO18BwOYwv3rHnUa9YBxzUzbfRsTXP1Df339v6Is/OhLS7VzQ6yuilaQ
         R883QiRI3IZAgpTaOn5aQUPjujetDX96MZWe+E6ZYVLj8+dWmQz4o9Q6J2w4nyLCHC6A
         FzdVPcBh3stlZnS2vicnmvR7GbDDdZjYlon3RAGKiX2q9n83mK7oXvNqZu48MxIe6yhy
         Z8CI7OSMFuTu/HPSBoYIKC0x0ffVzbNmSGAwy2eQzWvurJf23jT75g3s9OumJ2I/SGl3
         kTSbaSW5kbRcBncNTjyLAmQy1BQv1gTOjT2o31ijPD7PfhE88fmC1FxOP+5yw7DIYe8g
         I2Aw==
X-Received: by 10.68.244.73 with SMTP id xe9mr39450175pbc.98.1433861419813;
        Tue, 09 Jun 2015 07:50:19 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.191.155])
        by mx.google.com with ESMTPSA id rt8sm5890379pbb.37.2015.06.09.07.50.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 07:50:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150609142550.GB7894@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271188>

On 06/09/2015 07:55 PM, Jeff King wrote:
> On Tue, Jun 09, 2015 at 07:36:20PM +0530, Sitaram Chamarty wrote:
> 
>>> This patch prints the latest SHA-1 before the forced push in full. He
>>> then can do
>>>
>>>     git push <remote> +<old-sha1>:<ref>
>>>
>>> He does not even need to have the objects that <old-sha1> refers
>>> to. We could simply push an empty pack and the the remote will happily
>>> accept the force, assuming garbage collection has not happened. But
>>> that's another and a little more complex patch.
>>
>> If I am not mistaken, we actively prevent people from downloading an
>> unreferenced SHA (such as would happen if you overwrote refs that
>> contained sensitive information like passwords).
>>
>> Wouldn't allowing the kind of push you just described, require negating
>> that protection?
> 
> No, this has always worked. If you have write access to a repository,
> you can fetch anything from it with this trick. Even if we blocked this,
> there are other ways to leak information. For instance, I can push up
> objects that are "similar" to the target object, claim to have the
> target object, and then hope git will make a delta between my similar
> object and the target. Iterate on the "similar" object and you can
> eventually figure out what is in the target object.

aah ok; I must have mis-remembered something.  Thanks!
