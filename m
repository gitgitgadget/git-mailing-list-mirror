From: Daniel Devlin <devlin-d1@email.ulster.ac.uk>
Subject: could not verify object error
Date: Thu, 12 Feb 2015 12:32:45 +0000 (UTC)
Message-ID: <loom.20150212T132927-657@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 13:40:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLt44-0004Mn-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 13:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbbBLMkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 07:40:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:47197 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755773AbbBLMkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 07:40:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YLt3s-0004HN-9g
	for git@vger.kernel.org; Thu, 12 Feb 2015 13:40:04 +0100
Received: from 82-69-0-236.dsl.in-addr.zen.co.uk ([82.69.0.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 13:40:04 +0100
Received: from devlin-d1 by 82-69-0-236.dsl.in-addr.zen.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 13:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.69.0.236 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263735>

Hi there,

I have been running:
repo = Rugged::Config.global
type = "commit"
tagname = "v99.99.2"
username = repo["user.name"]
email = repo["user.email"]
message = "this is the message for the annotated tag"
tag_contents = 
"object f849f9e28c7f36a826d4b451efb16516c0c3acc2\ntype #{type}\ntag #
{tagname}\ntagger #{username} <#{email}> #{Time.new.to_i} +0000\n\n#{message}"
#puts tag_contents
#puts "****************************"
#puts command
executecommand = "printf \"#{tag_contents}\" | git mktag"

Open3.popen3(executecommand) do |stdin, stdout, stderr, wait_thr|

  exit_stats = wait_thr.value
  errors = stderr.readlines
  puts "Errors are #{errors}"
  unless exit_stats.success?
    raise Exception, 'There was an error encountered'
  end
  signature_file_sha = stdout.readline.chomp
  puts "signature sha is #{signature_file_sha}"
end

on my local machine and it runs successfully. 
I have tried to run it on a vm with git 2.0.4 but keep 
getting char 7 could not verify object error message. 
Any suggestions as to why would be greatly 
appreciated.

Thanks,
Daniel
