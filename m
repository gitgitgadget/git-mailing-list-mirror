From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 16:36:37 +0100
Message-ID: <45EC3905.7070406@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org> <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 16:37:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOFFj-0005yS-UI
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 16:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933519AbXCEPgj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 10:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933525AbXCEPgi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 10:36:38 -0500
Received: from server.usilu.net ([195.176.178.200]:32895 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933519AbXCEPgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 10:36:37 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 16:36:36 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 05 Mar 2007 15:36:36.0210 (UTC) FILETIME=[0F436520:01C75F3C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41451>


>> +	/* Try with a wildcard match now.  */
>> +	sscanf(value, "refs/%*[^/]/*:%nrefs/remotes/%*[^/]/*%n",
>> +	       &len_first, &len_second);
>> +	if (len_first != -1 && len_second != -1
>> +	    && (len_second - 2) - len_first == remote_len + 13
>> +	    && !strncmp(value + len_first, start_ref, remote_len + 13)) {
>> +		/* Replace the star with the remote branch name.  */
>> +		asprintf(&config_repo, "%.*s%s",
>> +			 len_first - 3, value,
>> +			 start_ref + remote_len + 13);
> 
> Same here:
> 
> 	else if (!prefixcmp(value, "refs/") && (p = strchr(value, ':')) &&
> 			!memcmp(p + 1, start_ref, remote_len) &&
> 			!strcmp(p + 1 + remote_len, "/*")) {
> 		config_repo = xstrdup(value);
> 		config_repo[p - value] = '\0';
> 	}

This is not what my code does.  Are you saying that yours is correct, or that it should actually be the same in practice, or just that I should avoid sscanf/asprintf (which I won't do, since I got mildly insane after writing half of the function without sscanf -- and then decided that the C library is there to be used).

Paolo
