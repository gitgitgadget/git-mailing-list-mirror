From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 1/3] format-patch: create patch filename in one function
Date: Sat, 21 Mar 2009 23:56:19 -0700
Message-ID: <49C5E113.3020601@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com> <1237696363-6819-2-git-send-email-bebarino@gmail.com> <7vwsai86nw.fsf@gitster.siamese.dyndns.org> <49C5D3BC.3030100@gmail.com> <7veiwq82wc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 07:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlHd3-0000he-7R
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 07:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbZCVG4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 02:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbZCVG4Y
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 02:56:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:19705 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbZCVG4X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 02:56:23 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1316581rvb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=bztK8AqvEyvtzZBx+/3B8Tu9R3tplDi049wtQ9F+O6I=;
        b=DY+AXuutyuRXnsFpm+JgP0HIpHhI9quMUm5sUxArZXLv2HsmGxoUX/u7CoMYVAhLC/
         QRCwvICLLMuW8Xq9ODv61EcsER7CNZ52fdRNKr13GJORKPaeUCHHVURomzaY++3jHbTg
         QAkuJmH62pyCd2OvossY2JFfj1eX7oqKu78/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=TNNHH1a0RZY8NuoWGMKHpnBrpaRhWBjDKkjacFfDQ7MOArkSeo1kMrHtIKCy3F2S27
         9hiAl1nLOGK5icRcbRjagsl/5/rqQu3Ymg3qx9BJNopvWpZhzc4P4rUvpN47I0L6VoDd
         X+Ha4SoZvmBHYqr1Yo63xp88VHVzPYTRY99u4=
Received: by 10.114.74.18 with SMTP id w18mr3836114waa.205.1237704982126;
        Sat, 21 Mar 2009 23:56:22 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id l38sm4052361waf.33.2009.03.21.23.56.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Mar 2009 23:56:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090102)
In-Reply-To: <7veiwq82wc.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114126>

Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>> Junio C Hamano wrote:
>> ...
>>> IOW, you can introduce a new format specifier (say, "%f") to
>>> format_commit_message() and the implemention of get_patch_filename() would
>>> just prepare a strbuf and call format_commit_message() on it, no?
>> This sounds great! I'm new so I don't know where to look for something
>> like this.
>
> I suspect you may not even have to pass the generated string around if you
> did so.  Instead, you could pass the commit to log_write_email_headers()
> instead of sha1_to_hex(commit->object.sha1) from show_log(), and use the
> sha-1on the unix "From " line, and inside "if (opt->mime_boundar)", you
> can ask format_commit_message("%f") to come up with a filename.

I believe I won't be able to get the patch suffix at that point in the
code. Unless I decide to add that to the rev_info instead?
