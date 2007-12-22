From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH v3] Make git send-email accept $EDITOR with arguments
Date: Sat, 22 Dec 2007 09:47:50 +0100
Message-ID: <476CCF36.3010109@isy.liu.se>
References: <7vd4sz4uii.fsf@gitster.siamese.dyndns.org>	<1198284052-20590-1-git-send-email-hendeby@isy.liu.se> <7vr6hf35fh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, luciano@eurotux.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 09:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J601s-0003XU-J8
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 09:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbXLVIrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 03:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbXLVIrz
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 03:47:55 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:56925 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbXLVIrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 03:47:55 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 4D99D25A9B;
	Sat, 22 Dec 2007 09:47:53 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 04264-02; Sat, 22 Dec 2007 09:47:52 +0100 (MET)
Received: from [192.168.13.34] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 8303025A99;
	Sat, 22 Dec 2007 09:47:52 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vr6hf35fh.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69127>

Junio C Hamano wrote:
> Gustaf Hendeby <hendeby@isy.liu.se> writes:
> 
>> Currently git send-email does not accept $EDITOR with arguments, eg,
>> emacs -nw, when starting an editor to produce a cover letter.  This
>> patch changes this by letting the shell handle the option parsing.
>>
>> Signed-off-by:  Gustaf Hendeby <hendeby@isy.liu.se>
>> ---
>>
>> This is based on Junio's suggestion on most readable and compatible
>> solution.  I'm not sure if it is identical to the C solution for git
>> tag, but it seems to be a reasonable solution.
>>
>>  git-send-email.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 248d035..e47994a 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -400,7 +400,7 @@ EOT
>>  	close(C);
>>  
>>  	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
>> -	system($editor, $compose_filename);
>> +	system('sh', '-c', '$0 $@', $editor, $compose_filename);
>>  
>>  	open(C2,">",$compose_filename . ".final")
>>  		or die "Failed to open $compose_filename.final : " . $!;
>> -- 
>> 1.5.4.rc1.16.gc817f
> 
> Thanks.  Has this been tested?  IOW, did you compose this
> message with this patch?

Yes, I sent out the patch with git send-email, with git including the 
patch itself and EDITOR=emacsclient -a emacs.  I have also played around 
with it a bit trying to make sure it is valid, but no more rigorous 
testing that that.  I'm not really sure how I would do that.

Thanks for all comments from everyone, I have learned a lot!

/Gustaf
